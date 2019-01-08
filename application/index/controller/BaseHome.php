<?php
namespace app\index\controller;

use think\Controller;
use think\Request;
use think\Loader;
use think\Session;

use app\index\model\RepairLog as RepairLogModel;
use app\admin\model\Novel as NovelModel;

use app\index\controller\User as UserController;

Loader::import('jssdk.jssdk', EXTEND_PATH);

class BaseHome extends Controller{
    public function _initialize(){
        //分享，微信签名等信息获取
        $jssdk = new \JSSDK("wx70a6688ea8e2f89e", "8708726922b9008f13d5a371143f15b3");
        $signPackage = $jssdk->GetSignPackage();
        $this->assign('signPackage', $signPackage);
        //会员信息
        $userC = new UserController;
        $user = $userC->user_api();
        //分享信息
        Session::delete('share');
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
    public function getUrl(){
        $request = Request::instance();
         
        $url=$request->domain();
        return $url;
    }
    /**
     *这里最重要
     * 数据转换 stdClass Object转array
     * @access public
     */
    public function object_array($array) {
        if(is_object($array)) {
            $array = (array)$array;
        }
        if(is_array($array)) {
            foreach($array as $key=>$value) {
                $array[$key] =self::object_array($value);
            }
        }
        return $array;
    }

    
}