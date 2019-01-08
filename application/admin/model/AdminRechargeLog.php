<?php
namespace app\admin\model;

use think\Model;

class AdminRechargeLog extends Model{
    protected $title = "admin_recharge_log";

    /**
     * 关联管理员表
     */
    public function Admin()
    {
        return $this->belongsTo('admin', 'admin_id');
    }

    /**
     * 关联会员表
     */
    public function User()
    {
        return $this->belongsTo('user', 'user_id');
    }
}