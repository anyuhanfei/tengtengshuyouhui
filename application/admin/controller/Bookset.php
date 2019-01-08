<?php
namespace app\admin\controller;

use think\Controller;
use think\Request;
use think\Db;

use app\admin\controller\BaseAdmin;
use app\admin\model\SetSign as SetSignModel;
use app\admin\model\SetRecharge as SetRechargeModel;
use app\admin\model\SetReward as SetRewardModel;

class Bookset extends BaseAdmin
{
    /**
     * 签到规则列表
     */
    public function sign_set(){
        $order = 'sign_id desc'; //排序定义

        $list = SetSignModel::order($order)->paginate(10);
        $this->assign("list",$list);
        return view('sign_set');
    }

    /**
     * 签到规则添加.修改
     */
    public function save_sign_set(){
        $url = 'Bookset/sign_set';

        if(!Request::instance()->isAjax()){ //判断来源
            $this->error("非法提交",url($url));
            return;
        }
        $id = Request::instance()->param('id', 0);
        $day = Request::instance()->param('day', 0);
        $reward = Request::instance()->param('reward', 0);
        if($day == 0 || $reward == 0){ //判断数据提交
            $this->error("请填写正确的签到规则！",url($url));
            return;
        }
        if($id != 0){ //判断是添加还是修改
            $res = SetSignModel::get($id);
        }else{
            $res = new SetSignModel;
        }
        // 修改数据为提交数据
        $res->day = $day;
        $res->reward = $reward;
        // 保存修改
        if($res->save()){
            $this->success("操作成功！",url($url));
        }else{
            $this->error("操作失败！",url($url));
        }
    }

    /**
     * 获取一个签到规则的信息
     */
    public function sign_set_modify(){
        $id = Request::instance()->param('id', 0);
        $res = SetSignModel::get($id);
        echo json_encode($res);
    }

    /**
     * 删除签到规则
     */
    public function delete_sign_set(){
        $url = 'Bookset/sign_set';

        $id = Request::instance()->param('id', 0);
        $res = SetSignModel::get($id);
        if($res->delete()){
            $this->redirect($url);
        }else{
            $this->error("删除失败！",url($url));
        }
    }



    /**
     * 充值规则列表
     */
    public function recharge_set(){
        $order = 'recharge_id desc'; //排序定义

        $list = SetRechargeModel::order($order)->paginate(10);
        $this->assign("list",$list);
        return view('recharge_set');
    }

    /**
     * 充值规则添加.修改
     */
    public function save_recharge_set(){
        $url = 'Bookset/recharge_set';

        if(!Request::instance()->isAjax()){ //判断来源
            $this->error("非法提交",url($url));
            return;
        }
        $id = Request::instance()->param('id', 0);
        $money = Request::instance()->param('money', 0);
        $give_money = Request::instance()->param('give_money', 0);
        if($money == 0){ //判断数据提交
            $this->error("请填写正确的充值规则！",url($url));
            return;
        }
        if($id != 0){ //判断是添加还是修改
            $res = SetRechargeModel::get($id);
        }else{
            $res = new SetRechargeModel;
        }
        // 修改数据为提交数据
        $res->money = $money;
        $res->give_money = $give_money;
        $res->get_currency = $money * 100;
        $res->give_currency = $give_money * 100;
        // 保存修改
        if($res->save()){
            $this->success("操作成功！",url($url));
        }else{
            $this->error("操作失败！",url($url));
        }
    }

    /**
     * 获取一个充值规则的信息
     */
    public function recharge_set_modify(){
        $id = Request::instance()->param('id', 0);
        $res = SetRechargeModel::get($id);
        echo json_encode($res);
    }

    /**
     * 删除充值规则
     */
    public function delete_recharge_set(){
        $url = 'Bookset/recharge_set';

        $id = Request::instance()->param('id', 0);
        $res = SetRechargeModel::get($id);
        if($res->delete()){
            $this->redirect($url);
        }else{
            $this->error("删除失败！",url($url));
        }
    }


    /**
     * 打赏礼物列表
     */
    public function reward_set(){
        $order = 'reward_id desc'; //排序定义

        $list = SetRewardModel::order($order)->paginate(10);
        $this->assign("list",$list);
        return view('reward_set');
    }

    /**
     * 打赏礼物添加.修改
     */
    public function save_reward_set(){
        $url = 'Bookset/reward_set';

        if(!Request::instance()->isAjax()){ //判断来源
            $this->error("非法提交",url($url));
            return;
        }
        $image = Request::instance()->file('image');
        if($image){
            $image_name = uploads($image);
        }else{
            $image_name = '';
        }

        $id = Request::instance()->param('id', 0);
        $name = Request::instance()->param('name', '');
        $value = Request::instance()->param('value', 0);
        if($name == '' || $value == 0){ //判断数据提交
            $this->error("请填写正确的打赏礼物名称和价值！",url($url));
            return;
        }
        if($id != 0){ //判断是添加还是修改
            $res = SetRewardModel::get($id);
        }else{
            $res = new SetRewardModel;
        }
        // 修改数据为提交数据
        $res->name = $name;
        $res->value = $value;
        if($image_name != ''){
            $res->image = $image_name;
        }
        // 保存修改
        if($res->save()){
            $this->success("操作成功！",url($url));
        }else{
            $this->error("操作失败！",url($url));
        }
    }

    /**
     * 获取一个打赏礼物的信息
     */
    public function reward_set_modify(){
        $id = Request::instance()->param('id', 0);
        $res = SetRewardModel::get($id);
        echo json_encode($res);
    }

    /**
     * 删除打赏礼物
     */
    public function delete_reward_set(){
        $url = 'Bookset/reward_set';

        $id = Request::instance()->param('id', 0);
        $res = SetRewardModel::get($id);
        if($res->delete()){
            $this->redirect($url);
        }else{
            $this->error("删除失败！",url($url));
        }
    }

    /**
     * 书城设置
     */
    public function book_set(){
        $re = Db::table('set_book')->where('set_book_id', 1)->find();
        if(!$re){
            Db::table('set_book')->insert([
                'set_book_id'=>1,
                'like_number'=>0,
                'pid_number'=>0,
                'share_number'=>0,
                'share_reward'=>0,
                'phone_reward'=>0,
                'share_title'=>'',
                'share_content'=>'',
                'share_image'=>''
            ]);
            $re = array(
                'set_book_id'=>1,
                'like_number'=>0,
                'pid_number'=>0,
                'share_number'=>0,
                'phone_reward'=>0,
                'share_title'=>'',
                'share_content'=>'',
                'share_image'=>''
            );
        }
        $this->assign('re', $re);
        return $this->fetch('book_set');
    }

    /**
     * 书城设置修改
     */
    public function set_book_save(){
        $update['like_number'] = Request::instance()->param('like_number');
        $update['pid_number'] = Request::instance()->param('pid_number');
        $update['share_number'] = Request::instance()->param('share_number');
        $update['share_reward'] = Request::instance()->param('share_reward');
        $update['phone_reward'] = Request::instance()->param('phone_reward');
        $update['share_title'] = Request::instance()->param('share_title');
        $update['share_content'] = Request::instance()->param('share_content');
        $image = Request::instance()->file('share_image');
        if($image){
            $update['share_image'] = uploads($image);
        }
        $res = Db::table('set_book')->where('set_book_id',1)->update($update);
        if($res){
            $this->success('修改成功');
        }else{
            $this->error('修改失败!');
        }
    }

}
