<?php
namespace app\index\controller;

use think\Controller;
use think\Request;
use think\Cookie;
use think\Session;
use think\Db;

use think\Loader;

use app\index\controller\BaseHome;
use app\index\controller\User as UserController;

use app\admin\model\SetRecharge as SetRechargeModel;
use app\admin\model\Vip as VipModel;
use app\index\model\UserRechargeRecord as UserReChargeRecordModel;
use app\index\model\Order as OrderModel;

Loader::import('wxpay.index', EXTEND_PATH);
Loader::import('jssdk.jssdk', EXTEND_PATH);
// Loader::import('wxpay.example.Wxpay', EXTEND_PATH, '.JsApiPay.php');


class Recharge extends Controller
{

    public function _initialize(){
        $jssdk = new \JSSDK("wx70a6688ea8e2f89e", "8708726922b9008f13d5a371143f15b3");
        $signPackage = $jssdk->GetSignPackage();
        $this->assign('signPackage', $signPackage);
        //分享信息
        Session::delete('share');
        $userC = new UserController;
        $user = $userC->user_api();
        if(Session::get('share')){
            $share = Session::get('share');
        }else{
            $share = $userC->set_book();
            $share['link'] = "http://shucheng.dd371.com/index/login/login?uid={$user->user_id}";
            $share['share_image'] = "http://shucheng.dd371.com{$share['share_image']}";
            Session::set('share', $share);
        }
        $this->assign('share', $share);
        $this->assign('user_id', $user->user_id);
    }

    public function pays($openid, $money)
    {
        //生成订单
        $order_sn = date('YmdHis') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);

        //微信支付
        $tools = new \JsApiPay();
        $money = $money * 100;
        //②、统一下单
        $input = new \WxPayUnifiedOrder();
        $input->SetBody("充值");
        $input->SetAttach("充值");
        $input->SetOut_trade_no("$order_sn");
        $input->SetTotal_fee("$money");
        $input->SetTime_start(date("YmdHis"));
        $input->SetTime_expire(date("YmdHis", time() + 600));
        $input->SetGoods_tag("充值");
        $input->SetNotify_url("http://shucheng.dd371.com/Index/Recharge/notify/");
        $input->SetTrade_type("JSAPI");
        $input->SetOpenid($openid);
        $config = new \WxPayConfig();
        $order = \WxPayApi::unifiedOrder($config, $input);
        $jsApiParameters = $tools->GetJsApiParameters($order);
        return $jsApiParameters;
    }

    public function recharge(){
        return $this->fetch('recharge');
    }

    public function sc(){
        $userC = new UserController;
        $user = $userC->user_api();
        $this->assign('user_id', $user->user_id);
        return $this->fetch('sc');
    }

    public function paysub(){
        $r_id = Request::instance()->param('r_id');
        if($r_id == 1000){
            $money = 365;
        }else{
            $sr = SetRechargeModel::get($r_id);
            $money = $sr->money;
        }
        $this->assign('money',$money);
        Session::set('r_id', $r_id);

        $userC = new UserController;
        $user = $userC->user_api();
        $openid=$user->openid;
        $jsApiParameters = $this->pays($openid, $money);
        $this->assign('data', $jsApiParameters);
        return $this->fetch('paysub');
    }

    //主动发起回调
    public function ajax_notify(){
        $userC = new UserController;
        $user = $userC->user_api();
        $r_id = Session::get('r_id');
        if($r_id){
            if($r_id == 1000){
                //vip
                Db::table('user')->where('user_id', $user->user_id)->setField('vip', 1);
                $viplog = new VipModel;
                $viplog->user_id = $user->user_id;
                $viplog->vip_time = date('Y-m-d H:i:s', time());
                $viplog->save();
            }else{
                //给会员充值
                $sr = SetRechargeModel::get($r_id);
                $money = $sr->get_currency + $sr->give_currency;
                Db::table('user')->where('user_id', $user->user_id)->setInc('balance', $money);
                //增加充值记录
                $urr = new UserReChargeRecordModel;
                $urr->user_id = $user->user_id;
                $urr->number = $money;
                $urr->type = 1;
                $urr->add_time = date('Y-m-d H:i:s',time());
                $urr->save();
            }
            Session::delete('r_id');
        }
    }

    /**
     * 取消支付或支付失败，删除r_id
     */
    public function ajax_delete(){
        Session::delete('r_id');
    }

    

    /*微信返回数据*/
    public function notify(){
        //获取返回的xml
        $testxml  = file_get_contents("php://input");
        //将xml转化为json格式
        $jsonxml = json_encode(simplexml_load_string($testxml, 'SimpleXMLElement', LIBXML_NOCDATA));
        //转成数组
        $result = json_decode($jsonxml, true);
        
        if($result){
            //如果成功返回了
            if($result['return_code'] == 'SUCCESS'){
                // $order_sn = $result['out_trade_no'];
                // $order = OrderModel::where('order_sn', $order_sn)->find();
                // $user_id = $order->$user_id;
                // $r_id = $order->$r_id;
                // if($r_id == 1000){
                //     //vip
                //     Db::table('user')->where('user_id', $user_id)->setField('vip', 1);
                //     $viplog = new VipModel;
                //     $viplog->user_id = $user_id;
                //     $viplog->vip_time = date('Y-m-d H:i:s', time());
                //     $viplog->save();
                // }else{
                //     //给会员充值
                //     $sr = SetRechargeModel::get($r_id);
                //     $money = $sr->get_currency + $sr->give_currency;
                //     Db::table('user')->where('user_id', $user_id)->setInc('balance', $money);
                //     //增加充值记录
                //     $urr = new UserReChargeRecordModel;
                //     $urr->user_id = $user_id;
                //     $urr->number = $money;
                //     $urr->type = 1;
                //     $urr->add_time = date('Y-m-d H:i:s',time());
                //     $urr->save();
                // }
                // $order->status = 1;
                // $order->save();
            }
        }
    }
}