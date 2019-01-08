<?php
namespace app\index\controller;

use think\Controller;
use think\Request;
use think\Cookie;
use think\Session;

use app\index\controller\User as UserController;

use app\admin\model\User as UserModel;
use app\admin\model\Vip as VipModel;

class Login extends Controller
{
    protected $appid = "wx70a6688ea8e2f89e";
    protected $secret = "8708726922b9008f13d5a371143f15b3";
    protected $redirect_uri = "http://shucheng.dd371.com/index/login/login";

    function login(){
        //获取是否是分享进入，如果是则保存上级id
        $uid = Request::instance()->param('uid',0);
        if($uid != 0){
            Session::set('uid', $uid);
        }
        // //授权
        // $urlcode="https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$this->appid."&redirect_uri=".$this->redirect_uri."&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";

        // $code = Request::instance()->param('code', '');
        // if($code == ''){
        //     $this->redirect($urlcode);
        // }  
        
        // $url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$this->appid."&secret=".$this->secret."&code=".$code."&grant_type=authorization_code";
        
        // $result=json_decode(file_get_contents($url),true);
        // if(empty($result['access_token'])){
        //     echo '失败:access_token';exit;
        // }
        // $token=$result['access_token'];

        // $openid=$result['openid'];
        // $url="https://api.weixin.qq.com/sns/userinfo?access_token=".$token."&openid=".$openid."&lang=zh_CN";
        // $result=json_decode(file_get_contents($url),true);
        // if(empty($result['openid'])){
        //     echo '失败:openid';
        //     exit;
        // }


        $urlcode="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx70a6688ea8e2f89e&redirect_uri=http://shucheng.dd371.com/index/login/login&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		 
		if(empty(Request::instance()->param('code', ''))){
			header("location:".$urlcode);
		}
		
		$code=Request::instance()->param('code', '');
		//    		$url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxb4691e3f6abe8d48&secret=02af683d6e3827c209982216e2f2a551&code='.$code.'&grant_type=authorization_code";
		//     	    var_dump($code);exit;
		$url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx70a6688ea8e2f89e&secret=8708726922b9008f13d5a371143f15b3&code=".$code."&grant_type=authorization_code";
		
		$result=json_decode(file_get_contents($url),true);
		if(empty($result['access_token'])){
			echo '失败:access_token';exit;
		}
		$token=$result['access_token'];
		$openid=$result['openid'];
		$url="https://api.weixin.qq.com/sns/userinfo?access_token=".$token."&openid=".$openid."&lang=zh_CN";
		$result=json_decode(file_get_contents($url),true);
		//   	    var_dump($result);exit;
		if(empty($result['openid'])){
			echo '失败:openid';
			exit;
		}




        
        //获取到用户信息，保存数据库
        $v_user = UserModel::where('openid', $openid)->find();
        if(!$v_user){
            $user = new UserModel;
            $user->openid = $result['openid'];
            $user->user_name = $result['nickname'];
            $user->user_image = $result['headimgurl'];
            $user->add_time = date('Y-m-d H:i:s', time());
            if(Session::get('uid')){
                $user->pid = Session::get('uid');
            }
            $user->save();
            $user_id = $user->user_id;
            //判断父级的子级人数，大于20则成功vip
            $pid_user_count = UserModel::where('pid', Session::get('uid'))->count();
            $userC = new UserController;
            $max_pid_user_count = $userC->set_book()['pid_number'];
            if($pid_user_count >= $max_pid_user_count){
                $pid_user = UserModel::get(Session::get('uid'));
                if($pid_user == 0){
                    $pid_user->vip = 1;
                    $pid_user->save();
                    $vip = new VipModel;
                    $vip->user_id = $user_id;
                    $vip->vip_time = date('Y-m-d H:i:s', time());
                    $vip_res = $vip->save();
                }
            }
        }else{
            $user_id = $v_user->user_id;
        }
        Session::set('user_id', $user_id);
        $this->redirect('index/login');
        return;
        

        // $jewel=getNew("Jewel", "id=1", "");
        // $num=$jewel['number'];
        // $data=array();
        // $data['openid']=$result['openid'];
        // $data['nickname']=$result['nickname'];
        // $data['headimgurl']=$result['headimgurl'];
        // $data['time']=date("Y-m-d H:i:s");
        // $data['money']=$num;
        // $ob=D("User");
        // $openid=$data['openid'];
        // $re=$ob->where("openid='%s'",array('openid'=>$openid))->find();
        
        // if(!isset($re)){
        //     $res=$ob->add($data);
        //     session('userid',$res);
        // }else{
        //     session('userid',$re['id']);
        // }
        
        // header("location:".U('Home/Join/index'));
    }
}
