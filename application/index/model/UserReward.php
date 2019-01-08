<?php
namespace app\index\model;

use think\Model;

class UserReward extends Model{
    protected $title = "user_reward";

    /**
     * 关联小说表
     */
    public function Novel()
    {
        return $this->belongsTo('novel', 'novel_id')->field('novel_name');
    }

    /**
     * 关联会员表
     */
    public function User()
    {
        return $this->belongsTo('user', 'user_id')->field('user_id, user_name, user_image');
    }

    /**
     * 关联礼物设置
     */
    public function SetReward()
    {
        return $this->belongsTo('set_reward', 'reward_id');
    }
}