<template>
  <div class="block-box">
    <BlockHeader :title="title" />
    <div class="block-body">
      <Card v-for="(item) in playLists" :key="item.id" :listItem="item"></Card>
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
    return {};
  },
  computed: {
    playLists() {
      switch (this.title) {
        case "今日热播":
          return this.$store.getters.hotPlayList;
          break;
        case "新番放送":
          return this.$store.getters.rimanList;
          break;
        case "国产动漫":
          return this.$store.getters.guochuangList;
          break;
        case "番组计划":
          return this.$store.getters.fanzuList;
          break;
        case "剧场动画":
          return this.$store.getters.theaterList;
          break;
        case "影视":
          return this.$store.getters.filmTVList;
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