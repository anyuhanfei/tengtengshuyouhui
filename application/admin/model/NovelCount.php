<?php
namespace app\admin\model;

use think\Model;

class NovelCount extends Model{
    protected $title = "novel_count";

    /**
     * 关联novel_count表，书籍统计表，关联字段为novel_id
     */
    public function Novel()
    {
        return $this->belongsTo('novel', 'novel_id');
    }
}