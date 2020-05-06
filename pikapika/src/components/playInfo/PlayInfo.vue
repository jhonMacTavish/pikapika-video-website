<template>
  <div class="page-content">
    <router-view/>
    <div class="playInfo-content">
        <Ad/>
        <Episode/>
        <Block title="推荐"/>
        <Comment/>
    </div>
  </div>
</template>

<script>
import Ad from "../ad/Ad";
import Block from '../block/Block'
import Comment from '../comment/Comment'
import Episode from '../common/episode/Episode'

export default {
  name: "PlayInfo",
  data() {
    return {
      // params:{}
      objectInfo:{}
    };
  },
  created(){
    console.log("fetch", )
    this.fetch();
  },
  computed: {
  },
  watch: {},
  methods: {
    async fetch(){
      let params = this.$route.query;
      console.log("params", params);
      switch(params.t_id){
        case "1":
          let res = await this.$http.get(`/bangumis/${params.v_id}`);
          console.log("objinfo", res.data[0]);
          this.objectInfo = res.data[0];
          this.$store.commit("UpdateObjectInfo",this.objectInfo);
          break;
        case 2:
          break;
        case 3:
          break;
        case 4:
          break;
        default:
          break;
      }
      let res = await this.$http.get('/videos',{params});
      console.log("res", res.data.list);
      this.$store.commit("UpdateEpisodeList",res.data.list);
    }
  },
  components: {Ad,Block,Comment,Episode}
};
</script>

<style lang='less' scoped>
.page-content {
  width: 100% !important;
  margin-top: -20px;
  //   margin-left: -180px;
  //   margin-right: -180px;
  
  .playInfo-content{
    margin: 0 auto;
    width: 1160px;
  }
}
</style>
