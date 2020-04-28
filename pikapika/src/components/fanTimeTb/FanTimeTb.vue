<template>
  <div class="block-wrap">
    <div class="fanTimeTb-box">
      <BlockHeader title="新番时间表" />
      <div class="weekday">
        <ul>
          <li v-for="(item,index) in weekday" :key="item.id" @click="selectWeekday(index)">
            <span :class="{active:selectDay==index}">{{item.content}}</span>
            <div class="bottom-line" v-show="selectDay==index"></div>
          </li>
        </ul>
      </div>
      <div class="block-body">
        <FanBox v-for="item in fanTimeTable" :key="item.id" :listItem="item"/>
      </div>
    </div>
    <Leaderboard />
  </div>
</template>

<script>
import Leaderboard from "../leaderboard/Leaderboard";
import FanBox from "../common/fanBox/FanBox";
import BlockHeader from "../common/blockHeader/BlockHeader";

export default {
  name: "FanTimeTb",
  data() {
    return {
      selectDay: 0,
      fanTimeTable: [],
      weekday: [
        { id: 1, content: "星期一" },
        { id: 2, content: "星期二" },
        { id: 3, content: "星期三" },
        { id: 4, content: "星期四" },
        { id: 5, content: "星期五" },
        { id: 6, content: "星期六" },
        { id: 7, content: "星期日" }
      ]
    };
  },
  created(){
    this.fanTimeTable = this.$store.getters.fanTimeTable[this.selectDay]
  },
  watch:{
    selectDay(val,oldVal){
      if(val != oldVal)
        this.fanTimeTable = this.$store.getters.fanTimeTable[val];
    }
  },
  computed:{
  },
  methods: {
    selectWeekday(index) {
      this.selectDay = index;
    },
  },
  components: { FanBox, Leaderboard, BlockHeader }
};
</script>

<style lang="less" scoped>
  .block-wrap{
    display: flex;
    justify-content: space-between;
    .fanTimeTb-box {
      width: 70%;
      .weekday {
        margin-top: 20px;
        padding-bottom: 3px;
        width: 100%;
        height: 30px;
        line-height: 30px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        ul {
          display: flex;
          justify-content: center;
          li {
            position: relative;
            display: inline-block;
            width: 80px;
            height: 100%;
            text-align: center;
            .bottom-line {
              position: absolute;
              width: 100%;
              height: 2px;
              bottom: -4px;
              background: #00a1d6;
            }

            span.active {
              color: #00a1d6;
            }
          }
          li:hover {
            color: #00a1d6;
            cursor: pointer;
          }
        }
      }

      .block-body {
        margin-right: 17px;
        width: 100%;
        height: 324px;
        overflow: auto;
        .rightCard{
          margin-right: -2px;
        }

        div.fanBox-box:nth-child(4n+0){
          margin-right: 0;
        }
      }

      .block-body::after{
          content: '';
          display: block;
          clear: both;
          visibility: hidden;
      }
    }
  }
</style>