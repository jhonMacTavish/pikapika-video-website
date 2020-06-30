<template>
  <div class="episode-box">
    <div class="tip">选集</div>
    <div class="wrap">
      <ul>
        <li v-for="(item,index) in episodeList" :key="item.resource_id">
          <el-button
            class="button-style"
            type="primary"
            size="small"
            @click="handleClick(index)"
            plain
          >第{{item.episode}}话</el-button>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "Episode",
  data() {
    return {};
  },
  computed: {
    episodeList() {
      return this.$store.getters.episodeList;
    },

    objectInfo(){
      return this.$store.getters.objectInfo;
    }
  },
  watch: {},
  methods: {
    async handleClick(index){
      // $router.push({name:'play',params:item});
      // this.$router.push({name:'play',query:{index}});
      
      if(this.$route.path.split('/').pop()-1 == index){
        return
      }
      //console.log("play", index+1);
      // this.$router.push(`/playinfo/play/${index+1}`);
      let {type_id,film_id} = this.objectInfo;
      let params = {type_id,film_id};
      let res = await this.$http.put("volumes",{params});
      // params.type_id = this.objectInfo.type_id;
      // params.film_id = this.objectInfo.film_id;
      this.$router.push(`/playinfo/play/${type_id}/${film_id}/${index+1}`);
      this.$router.go(0);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.episode-box {
  margin-top: 10px;

  .tip {
    padding-bottom: 2px;
    border-bottom: 2px solid #00a1d6;
  }
  .wrap {
    position: relative;

    ul {
      margin: 10px 0;
      width: 100%;
      max-height: 294px;
      overflow: auto;
      li {
        float: left;
        display: inline-block;

        margin-bottom: 10px;
        margin-right: 15px;
        .button-style {
          width: 100px;
        }
      }

      li:nth-child(10n + 0) {
        margin-right: 0;
      }
    }

    ul::after {
      content: "";
      display: block;
      clear: both;
      visibility: hidden;
    }
  }
}
</style>
