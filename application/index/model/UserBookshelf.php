<?php
namespace app\index\model;

use think\Model;

class UserBookshelf extends Model{
    protected $title = "user_bookshelf";

    /**
     * 关联novel表
     */
    public function Novel()
    {
        return $this->belongsTo('novel','novel_id')->field('novel_id, novel_name, novel_image');
    }
}