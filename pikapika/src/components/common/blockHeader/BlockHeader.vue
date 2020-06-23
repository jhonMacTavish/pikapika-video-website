<template>
  <div class="blockHeader-box">
    <div class="title">
      <img :src="imgSrc" alt class="icon" />
      <span>{{title}}</span>
    </div>
    <router-link
      v-if="title!='今日热播'&&title!='新番时间表'&&title!='推荐'"
      :to="title=='排行榜'?{path:'/rankpage'}:{name:'general',params:{id:type}}"
      target="_blank"
      tag="a"
      class="card-content"
    >
      <el-button class="more" size="mini">更多</el-button>
    </router-link>
    <el-switch
      class="more"
      v-else-if="title=='新番时间表'"
      v-model="BGswitch"
      active-color="#FF8EB3"
      inactive-color="#39c5bb"
      active-text="国漫"
      inactive-text="番剧"
    ></el-switch>

    <!-- <el-button v-if="title!='今日热播'&&title!='新番时间表'&&title!='推荐'" @click="$router.push({name:'general',params:{id:type}})" class="more" size="mini">更多</el-button> -->
  </div>
</template>

<script>
export default {
  name: "BlockHeader",
  props: {
    title: ""
  },
  data() {
    return {
      BGswitch: false
    };
  },
  computed: {
    type() {
      switch (this.title) {
        case "番剧":
          return "bangumi";
          break;
        case "国漫":
          return "guoman";
          break;
        case "电影":
          return "theater";
          break;
        case "剧集":
          return "movie";
          break;
        default:
          break;
      }
    },

    imgSrc() {
      switch (this.title) {
        case "新番时间表":
          return "../../../../static/imgs/navbar/timetable.png";
          break;
        case "排行榜":
          return "../../../../static/imgs/navbar/leaderboard.png";
          break;
        case "番剧":
          return "../../../../static/imgs/navbar/bangumi2.png";
          break;
        case "国漫":
          return "../../../../static/imgs/navbar/guoman.png";

          break;
        case "电影":
          return "../../../../static/imgs/navbar/theater2.png";
          break;
        case "剧集":
          return "../../../../static/imgs/navbar/filmtv.png";
          break;
        case "推荐":
          return "../../../../static/imgs/navbar/recommend.png";
          break;
        default:
          break;
      }
    }
  },
  watch: {},
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.blockHeader-box {
  margin-top: 40px;
  width: 100%;
  position: relative;
  .title {
    height: 30px;
    line-height: 30px;

    img.icon {
      display: inline-block;
      // background: brown;
      margin-right: 8px;
      width: 30px;
      height: 30px;
    }

    span {
      position: relative;
      top: -6px;
      margin-left: 6px;
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
</style>
