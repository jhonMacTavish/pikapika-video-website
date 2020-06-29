<template>
  <div class="page-content">
    <router-view />
    <div class="playInfo-content">
      <Ad />
      <Episode />
      <Block title="推荐" />
      <Comment />
    </div>
  </div>
</template>

<script>
import Ad from "../ad/Ad";
import Block from "../block/Block";
import Comment from "../comment/Comment";
import Episode from "../common/episode/Episode";

export default {
  name: "PlayInfo",
  data() {
    return {
      // params:{}
      // objectInfo: {}
    };
  },
  created() {
    // //console.log("fetch");
    this.fetch();
  },
  computed: {
    getParams() {
      return this.$store.getters.videoParams;
    }
  },
  watch: {},
  // beforeDestroy() {
  //   //console.log("beforeDestroy");
  //   sessionStorage.removeItem("videoParams");
  // },
  methods: {
    async getVideos(path, params) {
      let res = await this.$http.get(`${path}/${params.film_id}`);
      // //console.log("objinfo", res.data[0]);
      console.log("res", res);
      this.objectInfo = res.data[0];
      this.$store.commit("UpdateObjectInfo", this.objectInfo);

      res = await this.$http.get("/videos", { params });
      // //console.log("res", res.data.list);
      this.$store.commit("UpdateEpisodeList", res.data.list);
    },

    async fetch() {
      let params = this.$route.query;
      if (JSON.stringify(params)=="{}") {
        console.log("*****************", );
        params = this.$route.params;
      }
      console.log("params", params);
      console.log("route", this.$route);
      if (params.type_id) {
        this.$store.commit("UpdateVideoParams", params);
      }

      params = JSON.stringify(params) == "{}" ? this.getParams : params;
      //console.log("params", params);
      switch (params.type_id) {
        case "1":
          this.getVideos("/bangumis", params);
          // let res = await this.$http.get(`/bangumis/${params.film_id}`);
          // this.objectInfo = res.data[0];
          // this.$store.commit("UpdateObjectInfo", this.objectInfo);

          // let res = await this.$http.get("/videos", { params });
          // this.$store.commit("UpdateEpisodeList", res.data.list);
          break;
        case "2":
          this.getVideos("/guomans", params);
          break;
        case "3":
          this.getVideos("/theaters", params);
          break;
        case "4":
          this.getVideos("/filmtvs", params);
          break;
        default:
          break;
      }
      // let res = await this.$http.get("/videos", { params });
      // //console.log("res", res.data.list);
      // this.$store.commit("UpdateEpisodeList", res.data.list);
    }
  },
  components: { Ad, Block, Comment, Episode }
};
</script>

<style lang='less' scoped>
.page-content {
  width: 100% !important;
  margin-top: -20px;
  //   margin-left: -180px;
  //   margin-right: -180px;

  .playInfo-content {
    margin: 0 auto;
    width: 1160px;
  }
}
</style>
