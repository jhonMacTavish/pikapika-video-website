<template>
  <div class="block-wrap">
    <div class="fanTimeTb-box">
      <BlockHeader title="新番时间表" @toggle="fetch" />
      <!-- <div class="weekday">
        <ul>
          <li v-for="(item,index) in weekday" :key="item.id" @click="selectWeekday(index)">
            <span :class="{active:selectDay==index}">{{item.content}}</span>
            <div class="bottom-line" v-show="selectDay==index"></div>
          </li>
        </ul>
      </div>-->
      <el-tabs v-model="activeName" :stretch="true" class="timetable" @tab-click="handleClick">
        <el-tab-pane label="星期一" name="1"></el-tab-pane>
        <el-tab-pane label="星期二" name="2"></el-tab-pane>
        <el-tab-pane label="星期三" name="3"></el-tab-pane>
        <el-tab-pane label="星期四" name="4"></el-tab-pane>
        <el-tab-pane label="星期五" name="5"></el-tab-pane>
        <el-tab-pane label="星期六" name="6"></el-tab-pane>
        <el-tab-pane label="星期日" name="7"></el-tab-pane>
      </el-tabs>
      <div class="block-body">
        <FanBox v-for="(item,index) in fanTimeTable[selectDay]" :key="index" :listItem="item" />
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
      // fanTimeTable: [],
      activeName: "1"
    };
  },
  created() {
    // this.fanTimeTable = this.$store.getters.fanTimeTable[this.selectDay];
  },
  watch: {
    // selectDay(val, oldVal) {
    //   if (val != oldVal)
    //     this.fanTimeTable = this.$store.getters.fanTimeTable[val];
    // }
  },
  computed: {
    fanTimeTable(){
      return this.$store.getters.fanTimeTable;
    }
  },
  methods: {
    async fetch(BGswitch) {
      let res = null;
      let fanTimeTable = [];
      if (!BGswitch) {
        res = await this.$http.get(`/newbangumis`);
      } else {
        res = await this.$http.get(`/newguomans`);
      }
      let list = res.data.list;
      for (let i = 0; i < 7; i++) {
        fanTimeTable.push([]);
      }
      for (let i = 0; i < list.length; i++) {
        switch (list[i].weekday) {
          case "星期一":
            fanTimeTable[0].push(list[i]);
            break;
          case "星期二":
            fanTimeTable[1].push(list[i]);
            break;
          case "星期三":
            fanTimeTable[2].push(list[i]);
            break;
          case "星期四":
            fanTimeTable[3].push(list[i]);
            break;
          case "星期五":
            fanTimeTable[4].push(list[i]);
            break;
          case "星期六":
            fanTimeTable[5].push(list[i]);
            break;
          case "星期天":
            fanTimeTable[6].push(list[i]);
            break;
          default:
            break;
        }
      }
      console.log("fanTimeTable", fanTimeTable);
      this.$store.commit("UpdateFanTimeTable", fanTimeTable);
    },

    selectWeekday(index) {
      this.selectDay = index;
    },

    handleClick() {
      switch (this.activeName) {
        case "1":
          this.selectDay = 0;
          break;
        case "2":
          this.selectDay = 1;
          break;
        case "3":
          this.selectDay = 2;
          break;
        case "4":
          this.selectDay = 3;
          break;
        case "5":
          this.selectDay = 4;
          break;
        case "6":
          this.selectDay = 5;
          break;
        case "7":
          this.selectDay = 6;
          break;
        default:
          break;
      }
      console.log("fanTimeTable", this.fanTimeTable[this.selectDay]);
    }
  },
  components: { FanBox, Leaderboard, BlockHeader }
};
</script>

<style lang="less" scoped>
.block-wrap {
  display: flex;
  justify-content: space-between;
  .fanTimeTb-box {
    width: 70%;

    .timetable {
      margin-top: 10px;
    }
    // .weekday {
    //   margin-top: 20px;
    //   padding-bottom: 3px;
    //   width: 100%;
    //   height: 30px;
    //   line-height: 30px;
    //   border-bottom: 1px solid rgba(0, 0, 0, 0.1);
    //   ul {
    //     display: flex;
    //     justify-content: center;
    //     li {
    //       position: relative;
    //       display: inline-block;
    //       width: 80px;
    //       height: 100%;
    //       text-align: center;
    //       .bottom-line {
    //         position: absolute;
    //         width: 100%;
    //         height: 2px;
    //         bottom: -4px;
    //         background: #00a1d6;
    //       }

    //       span.active {
    //         color: #00a1d6;
    //       }
    //     }
    //     li:hover {
    //       color: #00a1d6;
    //       cursor: pointer;
    //     }
    //   }
    // }

    .weekday {
      text-align: center;
      background: red !important;
    }

    .block-body {
      margin-right: 17px;
      width: 100%;
      height: 324px;
      overflow: auto;
      .rightCard {
        margin-right: -2px;
      }

      div.fanBox-box:nth-child(4n + 0) {
        margin-right: 0;
      }
    }

    .block-body::after {
      content: "";
      display: block;
      clear: both;
      visibility: hidden;
    }
  }
}
</style>