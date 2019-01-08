<?php
namespace app\admin\controller;

use think\Request;

use app\admin\model\User as UserModel;
use app\admin\model\UserLoginLog as UserLoginLogModel;
use app\index\model\UserRecentReading as UserRecentReadingModel;
use app\index\model\UserBookshelf as UserBookshelfModel;
use app\admin\model\AdminRechargeLog as AdminRechargeLogModel;
use app\index\model\UserReward as UserRewardModel;
use app\index\model\UserRechargeRecord as UserRechargeRecordModel;
use app\admin\model\Vip as VipModel;

class User extends BaseAdmin
{
    /**
     * 会员列表
     */
    public function user_list()
    {
        $order = 'user_id desc'; //排序定义

        $list = UserModel::order($order)->paginate(10);
        $this->assign("list",$list);
        return view('user_list');
    }

    /**
     * 充值钻石
     */
    public function recharge()
    {
        $recharge_number = Request::instance()->param('recharge_number', 0);
        $user_id = Request::instance()->param('user_id');
        $user = UserModel::get($user_id);
        $user->balance = $user->balance + $recharge_number;
        if($user->save()){
            //记录日志
            $log = new AdminRechargeLogModel;
            $log->admin_id = 1;
            $log->user_id = $user_id;
            $log->recharge_number = $recharge_number;
            $log->recharge_time = date('Y-m-d H:i:s', time());
            $log->save();
            return array('error_code'=>1, 'data'=>$user->balance, 'msg'=>'充值成功!');
        }else{
            return array('error_code'=>-1, 'data'=>$user->balance, 'msg'=>'充值失败!');
        }
    }

    /**
     * 最近阅读
     */
    public function readed()
    {
        $user_id = Request::instance()->param('id');
        $readed = UserRecentReadingModel::where('user_id', $user_id)->order('read_time desc')->paginate(10);
        $this->assign('list', $readed);
        $user = UserModel::get($user_id);
        $this->assign('user', $user);
        return view('readed');
    }

    /**
     * 书架
     */
    public function bookshelf()
    {
        $user_id = Request::instance()->param('id');
        $bookshelf = UserBookshelfModel::where('user_id', $user_id)->paginate(10);
        $this->assign('list', $bookshelf);
        $user = UserModel::get($user_id);
        $this->assign('user', $user);
        return view('bookshelf');
    }

    /**
     * 打赏记录
     */
    public function reward()
    {
        $user_id = Request::instance()->param('id');
        $reward = UserRewardModel::where('user_id', $user_id)->paginate(10);
        $this->assign('list', $reward);
        $user = UserModel::get($user_id);
        $this->assign('user', $user);
        return view('reward');
    }

    /**
     * 签到
     */
    public function sign()
    {
        $user_id = Request::instance()->param('id');
        $sign = UserRechargeRecordModel::where('user_id', $user_id)->where('type', 2)->paginate(10);
        $this->assign('list', $sign);
        $user = UserModel::get($user_id);
        $this->assign('user', $user);
        return view('sign');
    }

    /**
     * 会员充值记录
     */
    public function user_recharge_log()
    {
        $user_id = Request::instance()->param('id');
        $sign = UserRechargeRecordModel::where('user_id', $user_id)->where('type', 1)->order('rr_id desc')->paginate(10);
        $this->assign('list', $sign);
        $user = UserModel::get($user_id);
        $this->assign('user', $user);
        return view('user_recharge_log');
    }

    /**
     * 会员登录记录
     */
    public function user_login_log()
    {
        $user_id = Request::instance()->param('id');
        $sign = UserLoginLogModel::where('user_id', $user_id)->order('ll_id desc')->paginate(10);
        $this->assign('list', $sign);
        $user = UserModel::get($user_id);
        $this->assign('user', $user);
        return view('user_login_log');
    }

    /**
     * 后台充值记录
     */
    public function recharge_log()
    {
        $rlog = AdminRechargeLogModel::order('ar_id desc')->paginate(10);
        $this->assign('list', $rlog);
        return view('recharge_log');
    }

    /**
     * 会员充值记录
     */
    public function recharge_money()
    {
        $res = UserRechargeRecordModel::where('type', 1)->order('rr_id desc')->paginate(10);
        $this->assign('list', $res);
        return view('recharge_money');
    }

    /**
     * vip列表
     */
    public function vip()
    {
        $vip = VipModel::where('is_over_due')->paginate(10);
        foreach($vip as &$v){
            $v->end_time = date('Y-m-d H:i:s',(time($v->vip_time)+(60*60*24*365)));
        }
        $this->assign('list', $vip);
        return view('vip');
    }

    /**
     * 设置vip
     */
    public function get_vip()
    {
        $user_id = Request::instance()->param('id');
        $type = Request::instance()->param('type');
        $user = UserModel::get($user_id);
        $vip = new VipModel;
        $user->startTrans();
        $vip->startTrans();
        
        if($type == 2){ //设置为vip
            $user->vip = $type;
            $user_res = $user->save();
            $vip->user_id = $user_id;
            $vip->vip_time = date('Y-m-d H:i:s', time());
            $vip_res = $vip->save();
        }elseif($type == 0){ //取消vip
            $user->vip = $type;
            $user_res = $user->save();
            $vip_res = $vip->where('user_id', $user_id)->update(['is_over_due'=>0]);
        }
        if($vip_res === false || $user_res === false){
            $user->rollBack();
            $vip->rollBack();
            return array('error_code'=>-1, 'data'=>array(), 'msg'=>'系统错误，设置失败!');
        }else{
            $user->commit();
            $vip->commit();
            return array('error_code'=>1, 'data'=>array(), 'msg'=>'操作成功！', );
        }
        
    }
}