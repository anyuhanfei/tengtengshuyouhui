<?php
namespace app\index\model;

use think\Model;

class userRechargeRecord extends Model{
    protected $title = "user_recharge_record";

    public function User()
    {
        return $this->belongsTo('user','user_id');
    }

}