<?php
namespace app\index\controller;

use think\Controller;
use think\Request;
use think\Cookie;
use think\Session;

use app\index\controller\BaseHome;
use app\index\controller\User as UserController;

use app\admin\model\Novel as NovelModel;
use app\index\model\LbPlace as LbPlaceModel;
use app\index\model\Lb as LbModel;
use app\admin\model\NovelChapter as NovelChapterModel;
use app\admin\model\SetReward as SetRewardModel;
use app\index\model\UserLike as UserLikeModel;
use app\index\model\UserShelf as UserShelfModel;
use app\index\model\UserRecentReading as UserRecentReadingModel;
use app\index\model\Sys as SysModel;
use app\admin\model\NovelCount as NovelCountModel;
use app\index\model\UserBookshelf as UserBookshelfModel;
use app\index\model\UserReward as UserRewardModel;
use app\index\model\UserRecordLog as UserRecordLogModel;
use app\index\model\UserLookCon as UserLookConModel;
use app\admin\model\NovelClassify as NovelClassifyModel;
use app\index\model\UserSearch as UserSearchModel;
use app\index\model\UserLoginLog as UserLoginLogModel;
use app\admin\model\User as UserModel;
use app\index\model\UserSex as UserSexModel;
use app\admin\model\Vip as VipModel;


class Index extends BaseHome
{
    public $page_number = 10;

    public function login(){
        //在这里添加登录记录
        $userC = new UserController;
        $user = $userC->user_api();
        $ll = new UserLoginLogModel;
        $ll->user_id = $user->user_id;
        $ll->login_time = date('Y-m-d H:i:s',time());
        $ll->save();
        $this->redirect('index/index');
    }

    /**
     * 首页
     * 男女分类全部获取
     */
    public function index()
    {
        $userC = new UserController;
        $user = $userC->user_api();
        //男女生类别(默认为男生)
        $sex = $this->sex();
        
        //banner
        $banner = LbModel::where('fid', 1)->select();
        //热门推荐
        $hot = $this->single_query('novel_recommend', 1, 3, $sex);
        //主编推荐
        $eic = $this->single_query('novel_recommend', 2, 3, $sex);
        // var_dump($eic['0']->novel_count->number_of_reward_human);exit;
        //vip推荐
        $vip = $this->single_query('novel_recommend', 3, 2, $sex);
        //限时免费
        $free_of_charge = $this->single_query('free_of_charge', 1, 2, $sex);
        //客服信息
        $sys = SysModel::get(1);
        //最近阅读
        if($user){
            $reading = UserRecentReadingModel::where('user_id', $user->user_id)->order('read_time desc')->find();
        }else{
            $reading = array();
        }
        //判断vip是否过期
        if($user->vip == 1){
            //是vip
            
        }
        
        $this->assign('sex', $sex);
        $this->assign('banner', $banner);
        $this->assign('hot', $hot);
        $this->assign('eic', $eic);
        $this->assign('vip', $vip);
        $this->assign('free_of_charge', $free_of_charge);
        $this->assign('sys',$sys);
        $this->assign('reading', $reading);
        
        return $this->fetch('index');
    }

    /**
     * 修改会员性别记录
     */
    public function sex(){
        $sex = Request::instance()->param('sex', -1);
        $userC = new UserController;
        $user = $userC->user_api();
        $user_sex = UserSexModel::get($user->user_id);
        if(!$user_sex){ //新建一行数据
            $user_sex = new UserSexModel;
            $user_sex->user_id = $user->user_id;
            $user_sex->sex = 1;
            $user_sex->save();
            $user_sex = UserSexModel::get($user->user_id);
        }
        if($sex == -1){ //从其他页跳转而来
            $sex = $user_sex->sex;
        }else{ //主动选择男生女生
            $user_sex->sex = $sex;
            $res = $user_sex->save(); 
            $user_sex = UserSexModel::get($user->user_id);
        }
        return $sex;
    }

    /**
     * 小说单项分类接口
     * @param str $type 查询字段名
     * @param int $value 查询字段值
     * @param int $limit 查询条数，默认为全部
     * @return object 
     */
    public function single_query($type, $value, $limit = 0, $sex=-1){
        $obj = NovelModel::where($type, $value);
        if($sex != -1){
            $obj = $obj->where('novel_sex', $sex);
        }
        if($limit == 0){
            $obj = $obj->select();
        }else{
            $obj = $obj->limit($limit)->select();
        }
        return $obj;
    }

    /**
     * 排行榜
     */
    public function top()
    {
        $top = $this->top_api()['data'];
        $this->assign('top', $top);
        return $this->fetch('top');
    }

    /**
     * 排行榜接口
     * @param int $page
     * @param int $number
     * @return array 
     */
    public function top_api($page = 1, $number = 10)
    {   
        $start_number = ($page - 1) * $number;
        $top = NovelModel::join('novel_count c','c.novel_id=novel.novel_id')->order('c.number_of_reward desc')->limit($start_number, $page * $number)->select();
        return array('error_code'=>1, 'data'=>$top, 'msg'=>'排行榜');
    }

    /**
     * 书库（条件查询书籍展示页）
     */
    public function stack()
    {
        $nc = NovelClassifyModel::all();
        $this->assign('nc', $nc);

        //更新cookie
        $search = array();
        Cookie::set('stack', $search);

        //查询
        $novel = NovelModel::limit($this->page_number)->select();
        $this->assign('novel', $novel);

        return $this->fetch('stack');
    }

    /**
     * 搜索
     */
    public function search()
    {
        //搜索内容
        $search = Request::instance()->param('search', '');
        if($search != ''){
            //有搜索内容
            $res = NovelModel::where('novel_name', 'like', '%'.$search.'%')->select();
        }else{
            //精彩推荐
            $res = $this->single_query('novel_recommend', 4);
        }
        $this->assign('res', $res);
        $this->assign('search', $search);
        
        return $this->fetch('search');
    }

    /**
     * 书库更改筛选条件和下一页
     */
    public function stack_api()
    {
        $type = Request::instance()->param('type', '');
        if($type == 'search'){ //修改搜索条件
            $name = Request::instance()->param('name', '');
            $value = Request::instance()->param('value', -1);
            if($type == ''){
                return array('error_code'=>-1, 'data'=>array(), 'msg'=>'没有要筛选的条件');
            }
            //获取cookie，并把修改参数加入数组
            $search = Cookie::get('stack');
            if($search == array()){
                $search['nc_id'] = -1;
                $search['novel_sex'] = -1;
                $search['novel_status'] = -1;
                $search['free_of_charge'] = -1;
            }
            $search[$name] = $value;
            //遍历参数，把需要筛选的参数筛选
            $novel = New NovelModel;
            foreach($search as $k=>$v){
                if($v != -1){
                    $novel->where($k, $v);
                }
            }
            //查询
            $novel_res = $novel->limit($this->page_number)->select();
            if($novel_res){
                foreach($novel_res as $v){
                    $v->nc_name = $v->novel_classify->nc_name;
                    $v->number_of_reward_human = $v->novel_count->number_of_reward_human;
                }
            }
            //把更新过的数据加入cookie
            Cookie::set('stack', $search);
            return array('error_code'=>1, 'data'=>$novel_res, 'msg'=>'书库', 'next_page'=>2);
        }elseif($type == 'page'){ //下拉刷新
            $page = Request::instance()->param('page', 0);
            if($page == 0){
                return array('error_code'=>-1, 'data'=>array(), 'msg'=>'错误操作！');
            }
            //查询
            $search = Cookie::get('stack');
            $novel = New NovelModel;
            foreach($search as $k=>$v){
                if($v != -1){
                    $novel->where($k, $v);
                }
            }
            $start_number = ($page-1) * $this->page_number;
            $novel_res = $novel->limit($start_number, $this->page_number)->select();
            if($novel_res){
                foreach($novel_res as $v){
                    $v->nc_name = $v->novel_classify->nc_name;
                    $v->number_of_reward_human = $v->novel_count->number_of_reward_human;
                }
            }
            return array('error_code'=>1, 'data'=>$novel_res, 'msg'=>'书库', 'next_page'=>$page+1);
        }else{
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'错误操作');
        }
        
        // Cookie::set('stack',[1,2,3]);
    }

    /**
     * 推荐列表（热门推荐和主编推荐）
     */
    public function recommend()
    {
        $type = Request::instance()->param('type', 0);
        if($type == 0){
            //错误，重定向到首页
            $this->redirect('index/index');
        }
        //推荐列表
        $recommend = $this->single_query('novel_recommend', $type);
        $this->assign('recommend', $recommend);
        //推荐标题
        if($type == 1){
            $this->assign('title', '热门推荐');
        }else{
            $this->assign('title', '主编推荐');
        }
        return $this->fetch('recommend');
    }

    /**
     * 小说简介
     */
    public function novel_detail()
    {
        $novel_id = Request::instance()->param('novel_id', 0);
        if($novel_id == 0){
            //错误，重定向到首页
            $this->redirect('index/index');
        }
        //小说信息
        $novel = NovelModel::get($novel_id);
        //目录章节（3条）
        $chapter = NovelChapterModel::where('novel_id', $novel_id)->field('chapter_id, novel_id, title, spend, chapter_sort')->limit(3)->order('chapter_sort asc')->select();
        //打赏礼物
        $reward = SetRewardModel::order('value asc')->select();
        //打赏记录，第一页（引用方法）
        $reward_log = $this->reward_log($novel_id);

        //是否加入了书架
        $userC = new UserController;
        $user = $userC->user_api();
        $is_add_bookshelf = 0;
        if($user){
            $bookshelf = UserBookShelfModel::where('user_id', $user->user_id)->where('novel_id', $novel_id)->find();
            if($bookshelf){
                $is_add_bookshelf = 1;
            }
        }
        //开始阅读（最近）
        $reading = UserRecentReadingModel::where('user_id', $user->user_id)->where('novel_id', $novel_id)->order('read_time desc')->find();
        if(!$reading){
            $reading['novel_id'] = $novel_id;
            if($chapter){
                $reading['chapter_id'] = $chapter[0]->chapter_id;
            }else{
                $reading['chapter_id'] = NovelChapterModel::where('novel_id', $novel_id)->order('chapter_sort asc')->value('chapter_id');
            }
        }
        
        $this->assign('reading', $reading);
        $this->assign('novel', $novel);
        $this->assign('chapter', $chapter);
        $this->assign('reward', $reward);
        $this->assign('is_add_bookshelf', $is_add_bookshelf);
        $this->assign('reward_log', $reward_log);
        return $this->fetch('novel_detail');
    }

    /**
     * 打赏记录接口
     * @param int $novel_id 书籍id
     * @param int $page 页数
     * @return object
     */
    public function reward_log($novel_id, $page = 1, $type = 1)
    {
        $res = UserRewardModel::where('novel_id',$novel_id)->limit(($page-1)*$this->page_number, $this->page_number)->order('reward_time desc')->select();
        if($type != 1){
            $res_array = array();
            foreach($res as $k=>$v){
                $res_array[$k]['user_image'] = $v->user->user_image;
                $res_array[$k]['user_name'] = $v->user->user_name;
                $res_array[$k]['reward_time'] = $v->reward_time;
                $res_array[$k]['image'] = $v->set_reward->image;
            }
            return $res_array;
        }else{
            return $res;
        }
        
    }

    /**
     * 小说目录
     */
    public function novel_chapter(){
        //接收参数
        $novel_id = Request::instance()->param('novel_id', 0);
        $page = Request::instance()->param('page', 1);
        if($novel_id == 0){
            $this->redirect('index/index');
        }
        //获取共多少章数据
        $novel_count = NovelCountModel::get($novel_id);
        $this->assign('novel_count', $novel_count);
        $this->assign('page', $page);
        return $this->fetch('novel_chapter');
    }

    /**
     * 章节分页
     */
    public function novel_chapter_page($novel_id, $page = 1, $chapter_page_number = 50){
        $res = NovelChapterModel::where('novel_id',$novel_id)->field('chapter_id, novel_id, chapter_sort, title, spend')
                ->limit(($page-1)*$chapter_page_number, $chapter_page_number)->order('chapter_sort asc')->select();
        return $res;
    }

    /**
     * 点赞
     */
    public function like(){
        //接收参数
        $novel_id = Request::instance()->param('novel_id', 0);
        if($novel_id == 0){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'错误操作！');
        }
        //会员登录判断
        $userC = new UserController;
        $user = $userC->user_api();
        if(!$user){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'您未登陆，无法点赞！');
        }
        $user_id = $user->user_id;
        //判断进入点赞
        $today_like_number = UserLikeModel::where('user_id', $user_id)->whereTime('like_time','today')->count();
        $max_like_number = $userC->set_book()['like_number'];
        if($today_like_number >= $max_like_number){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'您今天的点赞数已用完，请明天再来点赞呦~');
        }
        //点赞操作,加入小说统计
        $novel_count = NovelCountModel::get($novel_id);
        $novel_count->number_of_likes += 1;
        $novel_count->save();
        //点赞记录
        $new_like = new UserLikeModel;
        $new_like->novel_id = $novel_id;
        $new_like->user_id = $user_id;
        $new_like->like_time = date('Y-m-d H:i:s',time());
        $new_like->save();
        return array('error_code'=>1, 'data'=>array(), 'msg'=>'点赞成功！');
    }

    /**
     * 加入书架
     */
    public function add_bookshelf()
    {
        //接收参数
        $novel_id = Request::instance()->param('novel_id', 0);
        if($novel_id == 0){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'错误操作！');
        }
        //判断登录
        $userC = new UserController;
        $user = $userC->user_api();
        if(!$user){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'您未登陆，无法添加书架！');
        }
        $user_id = $user->user_id;
        //添加书架操作
        $new_bookself = new UserBookshelfModel;
        $new_bookself->novel_id = $novel_id;
        $new_bookself->user_id = $user_id;
        if($new_bookself->save()){
            return array('error_code'=>1, 'data'=>array(), 'msg'=>'添加成功！');
        }else{
            return array('error_code'=>1, 'data'=>array(), 'msg'=>'系统错误，添加失败！');
        }
    }

    /**
     * 打赏
     */
    public function give_reward(){
        //接收参数
        $novel_id = Request::instance()->param('novel_id', 0); //书籍id
        $reward_id = Request::instance()->param('reward_id', 0); //礼物id
        if($novel_id == 0 || $reward_id == 0){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'错误操作！');
        }
        //判断登录
        $userC = new UserController;
        $user = $userC->user_api();
        if(!$user){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'您未登陆，无法打赏！');
        }
        $user_id = $user->user_id;
        //获取礼物信息
        $reward = SetRewardModel::get($reward_id);
        if(!$reward){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'没有此礼物信息！');
        }
        //获取书籍信息
        $novel = NovelModel::get($novel_id);
        if(!$novel){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'没有此书籍信息！');
        }
        //判断用户是否有足够的钻石
        if($user->balance < $reward->value){
            return array('error_code'=>-2, 'data'=>array(), 'msg'=>'您的余额不足，请先充值!');
        }
        //打赏操作（事务）；扣用户余额，添加打赏记录，累计书籍统计信息
        $novel_count = NovelCountModel::get($novel_id);
        $user_reward = new UserRewardModel;

        $user->startTrans();
        $user_reward->startTrans();
        $novel_count->startTrans();

        $user->balance = $user->balance - $reward->value; 
        $user_res = $user->save();//扣用户余额
        $novel_count->number_of_reward += $reward->value;
        $novel_count->number_of_reward_human += 1;
        $novel_count_res = $novel_count->save();//累计书籍统计信息
        $user_reward->user_id = $user_id;
        $user_reward->novel_id = $novel_id;
        $user_reward->reward_id = $reward_id;
        $user_reward->reward_time = date('Y-m-d H:i:s', time());
        $user_reward_res = $user_reward->save();//打赏记录
        if($user_res === false || $novel_count_res === false || $user_reward_res === false){
            $user->rollBack();
            $user_reward->rollBack();
            $novel_count->rollBack();
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'系统错误，打赏失败!');
        }else{
            $user->commit();
            $user_reward->commit();
            $novel_count->commit();
            //获取新增的打赏记录信息，有关联信息
            $new_user_reward = UserRewardModel::get($user_reward->user_reward_id);
            return array('error_code'=>1, 'data'=>array('number_of_reward'=>$novel_count->number_of_reward, 'user_reward'=>$new_user_reward), 'msg'=>'打赏成功！', );
        }
        
    }

    /**
     * 内容
     */
    public function novel_content(){
        //接收参数
        $novel_id = Request::instance()->param('novel_id', 0);
        $chapter_id = Request::instance()->param('chapter_id', 0);
        if($novel_id == 0 || $chapter_id == 0){
            $this->redirect('index/index');
        }
        //会员登录判断
        $userC = new UserController;
        $user = $userC->user_api();
        //获取内容
        $chapter = NovelChapterModel::get($chapter_id);
        $chapter->content = htmlspecialchars_decode($chapter->content);
        //扣费,vip不扣费,限时免费不扣费
        if($user->vip == 0){ //不是vip
            $novel = NovelModel::get($novel_id);
            if($novel->free_of_charge == 0){ //本书不是是限免
                if($chapter->spend > 0){ //收费
                    if(!$user){
                        return array('error_code'=>-1, 'data'=>array(), 'msg'=>'您未登陆，无法查看收费内容！');
                    }
                    $record_log = UserRecordLogModel::where('user_id', $user->user_id)->where('novel_id', $novel_id)->where('chapter_id', $chapter_id)->find();
                    if(!$record_log){ //不存在说明未购买本章
                        if($user->balance >= $chapter->spend){ //扣费并记录
                            $new_record_log = new UserRecordLogModel;
                            $user->startTrans();
                            $new_record_log->startTrans();
                            $user->balance -= $chapter->spend;
                            $res_user = $user->save();
                            $new_record_log->user_id = $user->user_id;
                            $new_record_log->novel_id = $novel_id;
                            $new_record_log->chapter_id = $chapter_id;
                            $new_record_log->spend = $chapter->spend;
                            $new_record_log->add_time = date('Y-m-d H:i:s', time());
                            $res_new_record_log = $new_record_log->save();
                            if($res_user === false || $res_new_record_log === false){
                                $new_record_log->rollBack();
                                $user->rollBack();
                            }
                            $user->commit();
                            $new_record_log->commit();
                        }else{ //余额不足，重定向
                            $this->redirect('user/charge');//充值页
                            return;
                        }
                    }
                }
            }
        }
        //更新最近阅读
        $readed = UserRecentReadingModel::where('user_id', $user->user_id)->where('novel_id', $novel_id)->find();
        if(!$readed){
            //未阅读过本书
            $new_read = new UserRecentReadingModel;
            $new_read->user_id = $user->user_id;
            $new_read->novel_id = $novel_id;
            $new_read->chapter_id = $chapter_id;
            $new_read->read_time = date('Y-m_d H:i:s', time());
            $new_read->save();
        }else{
            //阅读过
            $readed->chapter_id = $chapter_id;
            $readed->read_time = date('Y-m_d H:i:s', time());
            $readed->save();
        }
        //上一章，下一章
        $next_chapter_id = NovelChapterModel::where('novel_id', $novel_id)->where('chapter_sort', $chapter->chapter_sort+1)->value('chapter_id');
        $last_chapter_id = NovelChapterModel::where('novel_id', $novel_id)->where('chapter_sort', $chapter->chapter_sort-1)->value('chapter_id');
        //用户习惯
        $user_look_con = UserLookConModel::where('user_id', $user->user_id)->find();
        if(!$user_look_con){ //没有则创建
            $new_con = new UserLookConModel;
            $new_con->user_id = $user->user_id;
            $new_con->save();
        }
        //打赏礼物
        $reward = SetRewardModel::order('value asc')->select();
        //是否添加书架
        $is_add_bookshelf = 0;
        if($user){
            $bookshelf = UserBookShelfModel::where('user_id', $user->user_id)->where('novel_id', $novel_id)->find();
            if($bookshelf){
                $is_add_bookshelf = 1;
            }
        }
        //增加阅读量
        $nc = NovelCountModel::get($novel_id);
        $nc->reading_volume += 1;
        $nc->save();
        //渲染
        $this->assign('novel_id', $novel_id);
        $this->assign('chapter_id', $chapter_id);
        $this->assign('chapter', $chapter);
        $this->assign('next_chapter_id', $next_chapter_id);
        $this->assign('last_chapter_id', $last_chapter_id);
        $this->assign('user_look_con', $user_look_con);
        $this->assign('reward', $reward);
        $this->assign('is_add_bookshelf', $is_add_bookshelf);
        return $this->fetch('novel_content');
    }

    /**
     * 会员修改读书配置
     */
    public function look_con(){
        $font_size = Request::instance()->param('font_size', 0);
        $background = Request::instance()->param('background', 0);
        //会员登录
        $userC = new UserController;
        $user = $userC->user_api();
        //会员读书配置
        $user_look_con = UserLookConModel::get($user->user_id);
        if($user){ //会员登录
            if($font_size != 0){ //修改字体
                $user_look_con->font_size = $font_size;
            }
            if($background != 0){ //修改背景色
                $user_look_con->background = $background;
            }
            $user_look_con->save();
        }
    }































    // //上传图片
    // function add_img(){
    //     if(!is_string(input('image'))){
    //         $image=uploads('image');
    //     }
    //     if($image){
    //         $arr=$image;
    //     }else{
    //         $arr="发布失败";
    //     }
    //     echo $arr;
    // }
    
    // //多图上传
    // function add_imgs(){
    //     $files = request()->file('image');
    //     $data='';
    //     foreach($files as $file){
    //         $info = $file->move(str_replace("\\", "/", ROOT_PATH) . 'public' . DS . 'uploads');
    //         $pa=$info->getSaveName();
    //         $path=str_replace("\\", "/", $pa);
    //         $images=\think\Image::open(ROOT_PATH.'/public'.$path);
    //         $images->save(ROOT_PATH.'/public'.$path,null,60,true);
    //         $paths='uploads/'.$path.',';
    //         $data['image']=$paths;
    //     }
    //     echo $data;
    // }   
  
}
