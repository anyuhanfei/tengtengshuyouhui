<?php
namespace app\admin\controller;

use think\Controller;
use think\Request;

use app\admin\controller\BaseAdmin;
use app\admin\model\Novel as NovelModel;
use app\admin\model\NovelClassify as NovelClassifyModel;
use app\admin\model\NovelCount as NovelCountModel;
use app\admin\model\NovelChapter as NovelChapterModel;
use app\index\model\UserReward as UserRewardModel;

class Novel extends BaseAdmin
{
    /**
     * 小说列表
     */
    public function novel_list(){
        $order = 'novel_id desc'; //排序定义

        $search['novel_status'] = Request::instance()->param('status', -1);
        $search['novel_recommend'] = Request::instance()->param('recommend', -1);
        $search['free_of_charge'] = Request::instance()->param('free_of_charge', -1);
        $search['novel_sex'] = Request::instance()->param('sex', -1);
        $search['nc_id'] = Request::instance()->param('nc_id', -1);
        $where = array();
        foreach($search as $k=>$v){
            if($v != -1){
                $where[$k] = $v;
            }
        }
        $novel_name = Request::instance()->param('novel_name', '');
        $search['novel_name'] = $novel_name;
        if($novel_name != ''){
            $where['novel_name'] = ['like', '%'.$novel_name.'%'];
        }

        $list = NovelModel::with('NovelClassify')->where($where)->order($order)->paginate(10);
        $this->assign("list",$list);
        $this->assign('search', $search);

        //分类
        $this->novel_classify();
        return view('novel_list');
    }

    /**
     * 添加页面
     */
    public function novel_add(){
        $this->novel_classify();
        return view('novel_add');
    }

    /**
     * 添加小说
     */
    public function add_save(){
        $image = Request::instance()->file('novel_image');
        $new_novel = new NovelModel;
        if($image){
            $new_novel->novel_image = uploads($image);
        }else{
            $new_novel->novel_image = '';
        }
        $new_novel->nc_id = Request::instance()->param('nc_id', 0);
        $new_novel->novel_name = Request::instance()->param('novel_name', '');
        $new_novel->novel_author = Request::instance()->param('novel_author', '');
        $new_novel->novel_profile = Request::instance()->param('novel_profile', '');
        $new_novel->novel_word_number = Request::instance()->param('novel_word_number', 0);
        $new_novel->novel_status = Request::instance()->param('novel_status', 1);
        if($new_novel->novel_status == 0){
            $new_novel->novel_status = 1;
        }
        $new_novel->novel_recommend = Request::instance()->param('novel_recommend', 0);
        $new_novel->novel_sex = Request::instance()->param('novel_sex', 0);
        if(Request::instance()->param('free_of_charge', 'off') == 'on'){
            $new_novel->free_of_charge = 1;
        }else{
            $new_novel->free_of_charge = 0;
        }
        $new_novel->add_time = date('Y-m-d H:i:s',time());
        $new_novel->update_time = date('Y-m-d H:i:s',time());
        $new_novel->create_time = date('Y-m-d H:i:s',time());
        if($new_novel->save()){
            //添加成功，添加技术表数据
            $new_ncm = new NovelCountModel;
            $new_ncm->novel_id = $new_novel->novel_id;
            $new_ncm->save();
            $this->success("添加成功！",url('Novel/novel_list'));
        }else{
            $this->error("添加失败！",url('Novel/novel_list'));
        }
    }

    /**
     * 修改页面
     */
    public function novel_update(){
        $id = Request::instance()->param('id', 0);
        $novel = NovelModel::get($id);
        if(!$novel){
            $this->error("读取书籍信息失败！",url('Novel/novel_list'));
        }
        $this->assign('novel',$novel);
        $this->novel_classify();
        return view('novel_update');
    }

    /**
     * 修改提交
     */
    public function update_save(){
        $id = Request::instance()->param('novel_id', 0);
        $novel = NovelModel::get($id);
        $image = Request::instance()->file('novel_image');
        if($image){
            $novel->novel_image = uploads($image);
        }
        $novel->nc_id = Request::instance()->param('nc_id', 0);
        $novel->novel_name = Request::instance()->param('novel_name', '');
        $novel->novel_author = Request::instance()->param('novel_author', '');
        $novel->novel_profile = Request::instance()->param('novel_profile', '');
        $novel->novel_word_number = Request::instance()->param('novel_word_number', 0);
        $novel->novel_status = Request::instance()->param('novel_status', 0);
        $novel->novel_recommend = Request::instance()->param('novel_recommend', 0);
        $novel->novel_sex = Request::instance()->param('novel_sex', 0);
        if(Request::instance()->param('free_of_charge', 'off') == 'on'){
            $novel->free_of_charge = 1;
        }else{
            $novel->free_of_charge = 0;
        }
        $novel->update_time = date('Y-m-d H:i:s',time());
        if($novel->save()){
            $this->success("修改成功！",url('Novel/novel_list'));
        }else{
            $this->error("修改失败！",url('Novel/novel_list'));
        }
    }

    /**
     * 修改统计
     */
    public function novel_count_update(){
        $id = Request::instance()->param('id', 0);
        $novel = NovelModel::get($id);
        if(!$novel){
            $this->error("读取书籍信息失败！",url('Novel/novel_list'));
        }
        $this->assign('novel',$novel);
        return view('novel_count_update');
    }

    /**
     * 小说打赏记录
     */
    public function novel_reward()
    {
        $id = Request::instance()->param('id', 0);
        $list = UserRewardModel::where('novel_id', $id)->paginate(10);
        $this->assign('list',$list);
        $novel = NovelModel::get($id);
        $this->assign('novel',$novel);
        return view('novel_reward');
    }

    /**
     * 修改统计数据
     */
    public function novel_count_update_save(){
        $id = Request::instance()->param('novel_id', 0);
        $novel_count = NovelCountModel::get($id);
        $novel_count->reading_volume = Request::instance()->param('reading_volume', 0);
        $novel_count->number_of_likes = Request::instance()->param('number_of_likes', 0);
        $novel_count->number_of_reward = Request::instance()->param('number_of_reward', 0);
        $novel_count->number_of_reward_human = Request::instance()->param('number_of_reward_human', 0);
        if($novel_count->save()){
            $this->success("修改成功！");
        }else{
            $this->error("修改失败！");
        }
    }

    /**
     * 批量修改花费钻石
     */
    public function novel_chapter_update_spend()
    {
        $spend = Request::instance()->param('spend', 0);
        $start = Request::instance()->param('start', 0);
        $end = Request::instance()->param('end', 0);
        $novel_id = Request::instance()->param('novel_id', 0);
        $res = NovelChapterModel::where('novel_id', $novel_id)->where('chapter_sort', '>=', $start);
        if($end == 0){
            $this->error("修改失败！");
        }elseif($end == -1){

        }else{
            $res->where('chapter_sort', '<=', $end);
        }
        if($res->update(['spend'=>$spend])){
            $this->success("修改成功！");
        }else{
            $this->error("修改失败！");
        }
    }

    /**
     * 批量删除
     */
    public function novel_chapter_update_delete(){
        $start = Request::instance()->param('start', 0);
        $end = Request::instance()->param('end', 0);
        $novel_id = Request::instance()->param('novel_id', 0);
        $res = NovelChapterModel::where('novel_id', $novel_id)->where('chapter_sort', '>=', $start);
        if($end == 0){
            $this->error("删除失败！");
        }elseif($end == -1){

        }else{
            $res->where('chapter_sort', '<=', $end);
        }
        if($res->delete()){
            $this->success("删除成功！");
        }else{
            $this->error("删除失败！");
        }
    }

    /**
     * 小说删除（软删除）
     */
    public function novel_delete(){
        $id = Request::instance()->param('id', 0);
        $novel = NovelModel::get($id);
        $novel->delete_time = date('Y-m-d H:i:s');
        $novel->update_time = date('Y-m-d H:i:s');
        if($novel->save()){
            return array('error_code'=>1, 'data'=>array(), 'msg'=>'删除成功!');
        }else{
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'删除失败!');
        }
    }

    

    /**
     * 小说关联分类的列表，选择用
     */
    public function novel_classify(){
        $nc = NovelClassifyModel::select();
        $this->assign('nc', $nc);
    }

    /**
     * 小说章节目录
     */
    public function novel_chapter_list(){
        $id = Request::instance()->param('id', 0);
        $novel = NovelModel::get($id);
        if(!$novel){
            $this->error("读取书籍信息失败！",url('Novel/novel_list'));
        }
        $chapter = NovelChapterModel::where('novel_id',$novel->novel_id)->order('chapter_sort asc')->paginate(20);
        foreach($chapter as $v){
            $v->content = htmlspecialchars_decode($v->content);
        }
        $this->assign('novel',$novel);
        $this->assign('list',$chapter);
        return view('novel_chapter_list');
    }

    /**
     * txt文件导入并解析为单章内容
     * @version 1.1 添加正则规则
     */
    public function novel_import(){
        $txt = Request::instance()->file('file');
        $start = Request::instance()->param('start', 0);
        $end = Request::instance()->param('end', 0);
        $regular = Request::instance()->param('regular', '');
        $novel_id = Request::instance()->param('novel_id', 0);
        if($txt){
            $txt_name = uploads($txt, 'txt');
        }else{
            $this->error("没有上传文件!");
        }
        if($regular != ''){
            //正则存在，优先用正则
            $res = txt_split(ROOT_PATH . 'public' . DS .$txt_name, $start, $end, $regular);
        }else{
            $res = txt_split(ROOT_PATH . 'public' . DS .$txt_name, $start, $end);
        }
        $i = 1;
        foreach($res as $v){
            $new_chapter = new NovelChapterModel;
            $new_chapter->save([
                'title'=>$v['title'],
                'content'=>$v['content'],
                'chapter_sort'=>$i,
                'novel_id'=>$novel_id
            ]);
            $i++;
        }
        //小说统计章节数++
        $this->update_chapter_number($novel_id, '+', $i - 1);
        $this->success("导入完成！");
    }
    
    /**
     * 正则表达式测试
     */
    public function regular_test(){
        $regular = Request::instance()->param('regular', '');
        $title = Request::instance()->param('title', '');
        if(preg_match("$regular", "$title") != false){
            $this->success("匹配成功");
        }else{
            $this->error('匹配失败');
        }
    }


    /**
     * 添加章节页面
     */
    public function novel_chapter_add(){
        $id = Request::instance()->param('id', 0);
        $novel = NovelModel::get($id);
        if(!$novel){
            $this->error("读取书籍信息失败！",url('Novel/novel_list'));
        }
        $this->assign('novel',$novel);
        return view('novel_chapter_add');
    }

    /**
     * 添加小说章节
     */
    public function chapter_add_save(){
        $id = Request::instance()->param('novel_id', 0);
        $novel = NovelModel::get($id);
        if(!$novel){
            $this->error("读取书籍信息失败！",url('Novel/novel_list'));
        }
        $new_chapter = new NovelChapterModel;
        $new_chapter->title = Request::instance()->param('title', 0);
        $new_chapter->novel_id = $id;
        $new_chapter->spend = Request::instance()->param('spend', '');
        $new_chapter->content = Request::instance()->param('content', '');
        $new_chapter->chapter_sort = Request::instance()->param('chapter_sort', '');
        if($new_chapter->save()){
            $this->update_chapter_number($id);
            $this->success("添加成功！");
        }else{
            $this->error("添加失败！");
        }
    }

    /**
     * 修改小说统计章节数
     */
    public function update_chapter_number($novel_id, $type = '+', $number = 1){
        $novel_c = NovelCountModel::get($novel_id);
        if($type == '-'){
            $novel_c->number_of_chapters -= $number;
        }else{
            $novel_c->number_of_chapters += $number;
        }
        $novel_c->update_time = date('Y-m-d H:i:s',time());
        $novel_c->save();
    }

    /**
     * 修改小说章节
     */
    public function novel_chapter_update(){
        $id = Request::instance()->param('id', 0);
        $chapter = NovelChapterModel::get($id);
        $this->assign('chapter',$chapter);
        return view('novel_chapter_update');
    }

    /***
     * 修改小说章节save
     */
    public function chapter_update_save(){
        $id = Request::instance()->param('chapter_id', 0);
        $chapter = NovelChapterModel::get($id);
        $chapter->title = Request::instance()->param('title');
        $chapter->content = Request::instance()->param('content');
        $chapter->spend = Request::instance()->param('spend');
        $chapter->chapter_sort = Request::instance()->param('chapter_sort');
        if($chapter->save()){
            $this->success("修改成功！");
        }else{
            $this->error("修改失败！");
        }
    }

    /**
     * 修改本章花费的金额
     */
    public function update_spend(){
        $id = Request::instance()->param('id', 0);
        $chapter = NovelChapterModel::get($id);
        $chapter->spend = Request::instance()->param('spend');
        if($chapter->save()){
            return array('error_code'=>0, 'data'=>array(), 'msg'=>'修改成功');
        }else{
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'修改失败');
        }
    }

    /**
     * 修改本章排序
     */
    public function update_sort(){
        $id = Request::instance()->param('id', 0);
        $chapter = NovelChapterModel::get($id);
        $chapter->chapter_sort = Request::instance()->param('sort');
        if($chapter->save()){
            return array('error_code'=>0, 'data'=>array(), 'msg'=>'修改成功');
        }else{
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'修改失败');
        }
    }

    /**
     * 删除章节
     */
    public function delete_chapter(){
        $id = Request::instance()->param('id', 0);
        $chapter = NovelChapterModel::get($id);
        $novel_id = $chapter->novel_id;
        if($chapter->delete()){
            //小说统计章节数--
            $this->update_chapter_number($novel_id, '-', 1);
            $this->success("删除成功！");
        }else{
            $this->error("删除失败！");
        }
    }

    /**
     * 小说分类列表
     */
    public function novel_classify_list(){
        $order = 'nc_id desc'; //排序定义

        $list = NovelClassifyModel::order($order)->paginate(10);
        $this->assign("list",$list);
        return view('novel_classify_list');
    }

    /**
     * 小说分类添加.修改
     */
    public function save_novel_classify(){
        $url = 'Novel/novel_classify_list';

        if(!Request::instance()->isAjax()){ //判断来源
            $this->error("非法提交",url($url));
            return;
        }
        $id = Request::instance()->param('id', 0);
        $name = Request::instance()->param('name', '');
        if($name == ''){ //判断数据提交
            $this->error("请填写名称！",url($url));
            return;
        }
        if($id != 0){ //判断是添加还是删除
            $res = NovelClassifyModel::get($id);
        }else{
            $res = new NovelClassifyModel;
        }
        // 修改数据为提交数据
        $res->nc_name = $name;
        // 保存修改
        if($res->save()){
            $this->success("操作成功！",url($url));
        }else{
            $this->error("操作失败！",url($url));
        }
    }

    /**
     * 获取一个小说分类的信息
     */
    public function novel_classify_modify(){
        $id = Request::instance()->param('id', 0);
        $res = NovelClassifyModel::get($id);
        echo json_encode($res);
    }

    /**
     * 删除小说分类
     */
    public function delete_novel_classify(){
        $url = 'Novel/novel_classify_list';

        $id = Request::instance()->param('id', 0);
        $res = NovelClassifyModel::get($id);
        if($res->delete()){
            $this->redirect($url);
        }else{
            $this->error("删除失败！",url($url));
        }
        
    }
}