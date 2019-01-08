<?php
namespace app\admin\model;

use think\Model;

use traits\model\SoftDelete;

class Novel extends Model{
    protected $title = "novel";

    use SoftDelete;
    protected $autoWriteTimestamp = 'datetime';
    protected $deleteTime = 'delete_time';

    /**
     * 状态,status_text
     */
    public function getNovelStatusTextAttr($value,$data)
    {
        $status = [1=>'连载中',2=>'已完结'];
        return $status[$data['novel_status']];
    }
    
    // /**
    //  * 把创建时间自动转换为时间戳，系统又会自动转换为date
    //  */
    // public function getCreateTimeAttr($value)
    // {
    //     return strtotime($value);
    // }

    /**
     * 推荐,recommend_text
     */
    public function getNovelRecommendTextAttr($value,$data)
    {
        $recommend = [0=>'未推荐',1=>'热门推荐',2=>'主编推荐',3=>'vip推荐',4=>'精彩推荐'];
        return $recommend[$data['novel_recommend']];
    }

    /**
     * 收费,free_of_charge_text
     */
    public function getFreeOfChargeTextAttr($value,$data)
    {
        $free_of_charge = [0=>'收费',1=>'限时免费'];
        return $free_of_charge[$data['free_of_charge']];
    }

    public function getNovelSexTextAttr($value, $data)
    {
        $novel_sex_text = [0=>'男',1=>'女'];
        return $novel_sex_text[$data['novel_sex']];
    }

    /**
     * 对应关联novel_classify表，关联字段为nc_id
     */
    public function NovelClassify()
    {
        return $this->belongsTo('novel_classify', 'nc_id')->field('nc_id, nc_name');
    }

    /**
     * 关联novel_count表，书籍统计表，关联字段为novel_id
     */
    public function NovelCount()
    {
        return $this->hasOne('novel_count', 'novel_id');
    }
    
    public function getCreateTimeAttr($time)
    {
        return $time;
    }
}