<template>
  <div class="block-box">
    <BlockHeader :title="title" />
    <div class="block-body">
      <Card v-for="(item) in videoList" :key="item.film_id" :listItem="item"></Card>
    </div>
  </div>
</template>

<script>
import Card from "../common/card/Card";
import BlockHeader from "../common/blockHeader/BlockHeader";

export default {
  name: "Block",
  props: {
    title: ""
  },
  data() {
    return {
      videoList: []
    };
  },
  computed: {
    getParams() {
      return this.$store.getters.videoParams;
    }
  },
  created() {
    this.fetch();
    // //console.log("route", this.getParams);
  },
  methods: {
    async getBangumis(path) {
      let res = await this.$http.get(path);
      // //console.log("res", res.data.list);
      this.videoList = res.data.list;

      let length = this.videoList.length;
      length = length >= 12 ? 12 : length < 6 ? length : 6;
      this.videoList.length = length;

      // //console.log(path, this.videoList);
    },

    async recommendList() {
      let params = this.getParams;
      let path =
        params.type_id == 1
          ? "/bangumis"
          : params.type_id == 2
          ? "/guomans"
          : params.type_id == 3
          ? "/theaters"
          : "/filmtvs";
      await this.getBangumis(path, 7);
      let list = this.videoList;
      let arr = [];
      for (let i = 0; i < list.length; i++) {
        if (list[i].type_id == params.type_id && list[i].film_id == params.film_id) {
          continue;
        }
        arr.push(list[i]);
      }

      if (arr.length > 6) {
        arr.length = 6;
      }
      this.videoList = arr;
      //console.log("videoList", this.videoList);
    },

    async fetch() {
      switch (this.title) {
        case "今日热播":
          return this.$store.getters.hotPlayList;
          break;
        case "新番放送":
          return this.$store.getters.rimanList;
          break;
        case "国漫":
          // return this.$store.getters.guomanList;
          this.getBangumis("/guomans");
          break;
        case "番剧":
          this.getBangumis("/bangumis");
          // return this.$store.getters.bangumiList;
          // let resB = await this.$http.get("/bangumis");
          // //console.log("resB", resB.data.list);
          // this.videoList = resB.data.list;
          // if (this.videoList.length > 12) {
          //   this.videoList.length = 12;
          // }
          break;
        case "电影":
          this.getBangumis("/theaters");

          break;
        case "剧集":
          this.getBangumis("/filmtvs");

          break;
        case "推荐":
          this.recommendList();
          // return this.$store.getters.bangumiList;
          // await this.getBangumis("/bangumis", 7);
          // let list = this.videoList;
          // let params = this.getParams;
          // let arr = [];
          // for (let i = 0; i < list.length; i++) {
          //   if (list[i].type_id == params.type_id && list[i].film_id == params.film_id) {
          //     continue;
          //   }
          //   arr.push(list[i]);
          // }

          // if (arr.length > 6) {
          //   arr.length = 6;
          // }
          // this.videoList = arr;
          // //console.log("videoList", this.videoList);
          break;
        default:
          break;
      }
    }
  },
  components: { Card, BlockHeader }
};
</script>

<style lang="less" scoped>
.block-box {
  width: 100%;
  .block-header {
    position: relative;
    .title {
      height: 30px;
      line-height: 30px;
      span {
        font-size: 24px;
        font-weight: 400;
      }
    }

    .more {
      position: absolute;
      right: 0;
      top: 5px;
      padding-top: 6px;
      padding-bottom: 6px;
    }
  }

  .block-body {
    width: 100%;

    div.card-box:nth-child(6n + 0) {
      margin-right: 0px;
    }
  }

  .block-body::after {
    content: "";
    display: block;
    clear: both;
    visibility: hidden;
  }
}
</style>