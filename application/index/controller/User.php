<?php
namespace app\index\controller;

use think\Controller;
use think\Request;
use think\Db;
use think\Session;
use think\Loader;

use app\index\controller\BaseHome;
use app\index\controller\Recharge as RechargeController;

use app\admin\model\User as UserModel;
use app\index\model\Sys as SysModel;
use app\admin\model\SetSign as SetSignModel;
use app\index\model\UserRechargeRecord as UserReChargeRecordModel;
use app\admin\model\SetRecharge as SetRechargeModel;
use app\index\model\UserRecordLog as UserRecordLogModel;
use app\index\model\UserBookshelf as UserBookshelfModel;
use app\index\model\UserReward as UserRewardModel;
use app\index\model\UserRecentReading as UserRecentReadingModel;

Loader::import('jssdk.jssdk', EXTEND_PATH);

class User extends Controller
{
    public $page_number = 10;

    public function _initialize(){
        $jssdk = new \JSSDK("wx70a6688ea8e2f89e", "8708726922b9008f13d5a371143f15b3");
        $signPackage = $jssdk->GetSignPackage();
        $this->assign('signPackage', $signPackage);
        $user = $this->user_api();
        $this->assign('user_id', $user->user_id);
        //分享信息
        Session::delete('share');
        if(Session::get('share')){
            $share = Session::get('share');
        }else{
            $share = $this->set_book();
            $share['link'] = "http://shucheng.dd371.com/index/login/login?uid={$user->user_id}";
            $share['share_image'] = "http://shucheng.dd371.com{$share['share_image']}";
            Session::set('share', $share);
        }
        $this->assign('share', $share);
    }

    /**
     * 个人信息(渲染)
     */
    public function user_show()
    {
        $user_id = Session::get('user_id');
        $user = UserModel::get($user_id);
        $this->assign('user', $user);
    }

    /**
     * 个人信息(返回值)
     */
    public function user_api()
    {
        $user_id = Session::get('user_id');
        if(!$user_id){
            $this->redirect('login/login');
        }
        $user = UserModel::get($user_id);
        return $user;
    }

    /**
     * 个人中心首页
     */
    public function center()
    {
        $this->user_show();
        $set_book = $this->set_book();
        $this->assign('set_book', $set_book);
        return $this->fetch('center');
    }

    /**
     * 充值
     */
    public function charge()
    {
        $this->user_show();
        $recharge = SetRechargeModel::order('money asc')->select();
        $this->assign('recharge',$recharge);
        $sys = SysModel::get(1);
        $this->assign('sys',$sys);
        return $this->fetch('charge');
    }

    /**
     * vip
     */
    public function vip()
    {
        $this->user_show();
        $sys = SysModel::get(1);
        $this->assign('sys',$sys);
        return $this->fetch('vip');
    }

    /**
     * 消费记录
     */
    public function buy()
    {
        $this->user_show();
        return $this->fetch('buy');
    }

    /**
     * 消费记录查询请求
     */
    public function buy_ajax($page = 1)
    {
        $user = $this->user_api();
        $res = UserRecordLogModel::where('user_id', $user->user_id)->limit(($page-1)*$this->page_number, $this->page_number)->select();
        if($res == array()){
            $error_code = -1;
        }else{
            foreach($res as $v){
                $v->novel_name = $v->novel->novel_name;
                $v->chapter_title = $v->novel_chapter->title;
            }
            $error_code = 1;
        }
        return array('error_code'=>$error_code, 'data'=>$res, 'msg'=>'', 'page'=>$page);
    }

    /**
     * 打赏记录查询请求
     */
    public function reward_ajax($page = 1)
    {
        $user = $this->user_api();
        $res = UserRewardModel::where('user_id', $user->user_id)->limit(($page-1)*$this->page_number, $this->page_number)->select();
        if($res == array()){
            $error_code = -1;
        }else{
            foreach($res as $v){
                $v->novel_name = $v->novel->novel_name;
                $v->reward_name = $v->set_reward->name;
                $v->reward_spend = $v->set_reward->value;
            }
            $error_code = 1;
        }
        return array('error_code'=>$error_code, 'data'=>$res, 'msg'=>'', 'page'=>$page);
    }

    /**
     * 充值记录页面(充值，签到)
     */
    public function recharge()
    {
        $user = $this->user_api();
        $sign = $this->recharge_api(2, $user->user_id);
        $recharge = $this->recharge_api(1, $user->user_id);
        $this->assign('sign', $sign['data']);
        $this->assign('recharge', $recharge['data']);
        $this->assign('sign_page', $sign['page']);
        $this->assign('recharge_page', $recharge['page']);
        return $this->fetch('recharge');
    }

    /**
     * 充值记录下页请求(充值，签到)
     */
    public function recharge_ajax()
    {
        $user = $this->user_api();
        $page = Request::instance()->param('page');
        $type = Request::instance()->param('type');
        $res = $this->recharge_api($type, $user->user_id, $page);
        if($res['data'] == array()){
            $res['error_code'] = -1;
        }
        return $res;
    }

    /**
     * 充值记录查询数据库接口(充值，签到)
     */
    public function recharge_api($type, $user_id, $page = 1)
    {
        $res = UserReChargeRecordModel::where('type', $type)->where('user_id', $user_id)->limit(($page-1)*$this->page_number, $this->page_number)->order('add_time desc')->select();
        return array('error_code'=>1, 'data'=>$res, 'msg'=>'', 'page'=>$page);
    }

    /**
     * 阅读记录
     */
    public function read()
    {
        $type = Request::instance()->param('type', 0);
        $this->assign('type', $type);
        $reading = $this->read_ajax('read')['data'];
        $bookshelf = $this->read_ajax('bookshelf')['data'];
        $this->assign('reading', $reading);
        $this->assign('bookshelf', $bookshelf);
        return $this->fetch('read');
    }

    /**
     * 阅读记录查询
     */
    public function read_ajax($type, $page = 1)
    {
        $user = $this->user_api();
        if($type == 'read'){
            $res = UserRecentReadingModel::limit(($page-1)*$this->page_number, $this->page_number)->where('user_id', $user->user_id)->order('read_time desc')->select();
        }elseif($type == 'bookshelf'){
            $res = UserBookshelfModel::limit(($page-1)*$this->page_number, $this->page_number)->where('user_id', $user->user_id)->order('bookshelf_id desc')->select();
        }
        foreach($res as $v){
            $v->novel_name = $v->novel->novel_name;
            $v->novel_image = $v->novel->novel_image;
        }
        return array('error_code'=>1, 'data'=>$res, 'msg'=>'', 'page'=>$page+1);
    }

    /**
     * 删除阅读记录或书架
     */
    public function read_del($table_type, $table_id)
    {
        if($table_type == 'read'){
            $res = UserRecentReadingModel::where('rr_id', $table_id)->delete();
        }elseif($table_type == 'bookshelf'){
            $res = UserBookshelfModel::where('bookshelf_id', $table_id)->delete();
        }
    }

    /**
     * 签到
     */
    public function sign()
    {
        $this->user_show();
        $sign = SetSignModel::all();
        $max = SetSignModel::max('reward');
        $min = SetSignModel::min('reward');
        $this->assign('sign', $sign);
        $this->assign('max', $max);
        $this->assign('min', $min);
        $user = $this->user_api();
        //查询今日是否已经签到
        $today_sign = Db::query("select * from user_recharge_record where user_id=$user->user_id AND type=2 AND DATE(add_time)='" . date('Y-m-d',time()) . "'");
        if($today_sign != array()){
            $this->assign('today_sign', 1);
        }else{
            $this->assign('today_sign', 0);
        }
        return $this->fetch('sign');
    }

    /**
     * 签到操作
     */
    public function sign_submit()
    {
        $user = $this->user_api();
        //查询今日是否已经签到
        $today_sign = Db::query("select * from user_recharge_record where user_id=$user->user_id AND type=2 AND DATE(add_time)='" . date('Y-m-d',time()) . "'");
        if($today_sign != array()){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'今日已签到，明天再来吧！');
        }
        //查询连续签到日期
        // $sign_time = date('Y-m-d', time()-24*60*60); //昨天（初始判断日期）
        $consecutive_check_ins = 1; //连续签到次数
        $is_pass = true; //是否可以执行循环
        $day_number = 1;
        do{
            $before_sign = Db::query("select * from user_recharge_record where user_id=" . $user->user_id . " AND type=2 AND DATE(add_time)='" . date('Y-m-d', time()-24*60*60*$day_number) . "'");
            if($before_sign){
                $consecutive_check_ins++; //签到次数+1
                $day_number++;
            }else{
                $is_pass = false;
            }
        }while($is_pass == true);
        //判断本次签到得到的金额
        $new_sign = new UserReChargeRecordModel;
        $new_sign->user_id = $user->user_id;
        $new_sign->type = 2;
        $new_sign->add_time = date('Y-m-d H:i:s', time());
        $day_max = SetSignModel::max('day');
        if($consecutive_check_ins > $day_max){
            //最大签到
            $reward = SetSignModel::max('reward');
            $new_sign->number = $reward; //记录金额
            $user_balance = $user->balance + $reward; //增加
        }elseif($consecutive_check_ins <= $day_max && $consecutive_check_ins > 1){
            //在签到规则内
            $signset = SetSignModel::where('day', $consecutive_check_ins)->find();
            $reward = $signset->reward;
            $new_sign->number = $signset->reward;
            $user_balance = $user->balance + $reward;
        }else{
            //第一天签到
            $reward = SetSignModel::min('reward');
            $new_sign->number = $reward;
            $user_balance = $user->balance + $reward;
        }
        //提交
        $new_sign->save();
        // $user->balance = $user_balance; 
        // $user->save(); //更新字段失败，未知BUG
        $user_db = Db::table('user')->where('user_id', $user->user_id)->setInc('balance', $reward);
        return array('error_code'=>1, 'data'=>array('reward'=>$reward), 'msg'=>'签到成功!');
    }

    //未完待续
    /**
     * 绑定手机号页面
     */
    public function phone()
    {
        $this->user_show();
        $type = Request::instance()->param('type', 0);
        $this->assign('type',$type);
        return $this->fetch('phone');
    }

    /**
     * 绑定手机号操作
     */
    public function phone_submit()
    {
        $user = $this->user_api();
        $this->assign('user', $user);
        $user_phone = Request::instance()->param('user_phone',0);
        $code = Request::instance()->param('code',0);
        if($code != Session::get('code')){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'验证码不符!');
        }
        if($user_phone == $user->user_phone){
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'新手机号和旧手机号相同，无法更改!');
        }
        
        if($user->user_phone == ''){
            //第一次绑定手机号
            $set_book = $this->set_book();
            $error_code = 1;
            $user->balance += $set_book['phone_reward']; 
        }else{
            //更改绑定手机号
            $error_code = 2;
        }
        $user->user_phone = $user_phone;
        if($user->save()){
            return array('error_code'=>$error_code, 'data'=>array(), 'msg'=>'绑定成功!');
        }else{
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'绑定失败!');
        }
    }

    public function send_code(){
        $phone = Request::instance()->param('phone',0);
        if($phone != 0){
            $code = mt_rand(100000, 999999);
            Post($phone, $code);
            Session::set('code', $code);
            return array('error_code'=>1, 'data'=>array(), 'msg'=>'获取验证码!');
        }else{
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'获取验证码失败!');
        }
        
    }

    /**
     * 客服中心
     */
    public function service()
    {
        $sys = SysModel::get(1);
        $this->assign('sys',$sys);
        return $this->fetch('service');
    }

    public function ready_return()
    {
        $user = $this->user_api();
        $set_book = $this->set_book();
        $max_share = $set_book['share_number'];
        $max_reward = $set_book['share_reward'];
        //判断今天的是否超过20条
        $share = Db::table('user_share')->where('user_id', $user->user_id)->whereTime('share_time', 'today')->count();
        if($share < $max_share){
            //小于20条，给阅读币
            Db::table('user')->where('user_id', $user->user_id)->setInc('balance', $max_reward);
        }
        Db::table('user_share')->insert([
            'user_id'=>$user->user_id,
            'share_time'=>date("Y-m-d H:i:s", time())
        ]);
    }

    /**
     * 书城设置
     */
    public function set_book(){
        $res = Db::table('set_book')->where('set_book_id',1)->find();
        return $res;
    }
}