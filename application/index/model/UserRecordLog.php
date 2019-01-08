<?php
namespace app\index\model;

use think\Model;

class UserRecordLog extends Model{
    protected $title = "user_record_log";


    public function Novel(){
        return $this->belongsTo('novel', 'novel_id')->field('novel_name');
    }

    public function NovelChapter(){
        return $this->belongsTo('novel_chapter', 'chapter_id')->field('title');
    }
}