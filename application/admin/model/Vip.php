<?php
namespace app\admin\model;

use think\Model;

class Vip extends Model{
    protected $title = "vip";

    /**
     * 关联会员表
     */
    public function User(){
        return $this->belongsTo('user', 'user_id');
    }

    /**
     * 是否过期字段
     */
    public function getIsOverDueTextAttr($value, $data)
    {
        $is_over_due_text = ['0'=>'已过期', '1'=>'vip'];
        return $is_over_due_text[$data['is_over_due']];
    }
}