<template>
  <div class="blockHeader-box">
    <div class="title">
      <svg
        t="1587718509099"
        class="icon"
        viewBox="0 0 1024 1024"
        version="1.1"
        xmlns="http://www.w3.org/2000/svg"
        p-id="2038"
        width="40"
        height="30"
      >
        <path
          d="M0 194.56m81.92 0l860.16 0q81.92 0 81.92 81.92l0 573.44q0 81.92-81.92 81.92l-860.16 0q-81.92 0-81.92-81.92l0-573.44q0-81.92 81.92-81.92Z"
          fill="#69C0FF"
          p-id="2039"
        />
        <path
          d="M143.36 921.6h122.88v30.72a40.96 40.96 0 0 1-40.96 40.96h-40.96a40.96 40.96 0 0 1-40.96-40.96v-30.72zM757.76 921.6h122.88v30.72a40.96 40.96 0 0 1-40.96 40.96h-40.96a40.96 40.96 0 0 1-40.96-40.96v-30.72z"
          fill="#40A9FF"
          p-id="2040"
        />
        <path
          d="M92.16 307.2m81.92 0l450.56 0q81.92 0 81.92 81.92l0 348.16q0 81.92-81.92 81.92l-450.56 0q-81.92 0-81.92-81.92l0-348.16q0-81.92 81.92-81.92Z"
          fill="#91D5FF"
          p-id="2041"
        />
        <path
          d="M865.28 363.52m-46.08 0a46.08 46.08 0 1 0 92.16 0 46.08 46.08 0 1 0-92.16 0Z"
          fill="#40A9FF"
          p-id="2042"
        />
        <path
          d="M865.28 517.12m-46.08 0a46.08 46.08 0 1 0 92.16 0 46.08 46.08 0 1 0-92.16 0Z"
          fill="#40A9FF"
          p-id="2043"
        />
      </svg>
      <span>{{title}}</span>
    </div>
     <router-link v-if="title!='今日热播'&&title!='新番时间表'&&title!='推荐'"
      :to="title=='排行榜'?{path:'/rankpage'}:{name:'general',params:{id:type}}"
      target="_blank"
      tag="a"
      class="card-content"
    >
      <el-button  class="more" size="mini">更多</el-button>
    </router-link>

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
    return {};
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
