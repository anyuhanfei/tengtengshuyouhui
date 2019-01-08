<?php
namespace app\index\model;

use think\Model;

class UserRecentReading extends Model{
    protected $title = "user_recent_reading";

    /**
     * 关联小说
     */
    public function Novel(){
        return $this->belongsTo('novel','novel_id')->field('novel_id, novel_name, novel_image');
    }

    /**
     * 关联章节
     */
    public function NovelChapter(){
        return $this->belongsTo('novel_chapter','chapter_id')->field('chapter_id, novel_id, chapter_sort, title, spend');
    }

}