<?php
namespace app\admin\model;

use think\Model;

class User extends Model{
    protected $title = "user";


    public function getVipTextAttr($value, $data)
    {
        $vip_text = ['0'=>'普通会员', '1'=>'vip', '2'=>'vip'];
        return $vip_text[$data['vip']];
    }
}