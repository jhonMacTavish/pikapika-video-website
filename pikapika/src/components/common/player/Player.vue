<template>
  <div class="player-box">
    <div id="player" class="player-wrap">
      <div class="title">
        <span>
          {{objectInfo.t_id==1?
          objectInfo.b_name:objectInfo.t_id==2?
          objectInfo.g_name:objectInfo.t_id==3?
          objectInfo.th_name:objectInfo.f_name}}
        </span>
        <span>第 {{this.id}} 话</span>
      </div>
      <div class="video-wrap">
        <div class="video-box">
          <!-- <video class="video" controls preload="加载中">
            <source
              :src="item.r_address"
              type="video/mp4"
            />您的浏览器不支持 HTML5 视频,请更换浏览器。比如 Chrome 、 Firefox 等主流浏览器。
          </video>-->
          <el-card class="box-card" body-style="padding:5px;background:rgba(0,0,0,0.2)">
            <video
              ref="video"
              preload="加载中"
              autobuffer="true"
              data-setup="{}"
              class="video"
              controls
            >
              <source type="video/mp4" />
              <div>
                <b>【错误】您使用的浏览器不支持HTML5视频...</b>
              </div>
            </video>
          </el-card>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "",
  props: {
    id: {
      type: String,
      default: 1
    }
  },
  data() {
    return {
      item: {},
      index: 0
    };
  },
  mounted() {
    const returnEle = document.querySelector("#player"); //window是将要跳转区域的id
    if (!!returnEle) {
      returnEle.scrollIntoView(true); // true 是默认的
    }
  },
  async created() {
    console.log("createPlayer");
    // this.item = this.$route.query;
    // console.log("playerRoute", this.item);
    let params = this.getParams;
    let res = await this.$http.get("/videos", { params });
    this.$store.commit("UpdateEpisodeList", res.data.list);

    console.log("id", this.id);
    this.index = this.id;
    --this.index;
    console.log("index", this.index);
    this.item = this.$store.getters.episodeList[this.index];
    console.log("this.item", this.item);

    this.item = this.$store.getters.episodeList[this.index];
    this.$refs.video.src = this.item.r_address;
    this.$refs.video.play();
  },
  computed: {
    objectInfo() {
      return this.$store.getters.objectInfo;
    },

    getParams() {
      return this.$store.getters.videoParams;
    }
  },
  watch: {
    id(newV, olV) {
      if (newV != olV) {
        this.index = this.id;
        --this.index;
        this.item = this.$store.getters.episodeList[this.index];

        this.$refs.video.src = this.item.r_address;
        this.$refs.video.play();
      }
      console.log("item", this.item);
    }
  },
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.player-box {
  margin: 0 auto;
  margin-top: -20px;

  width: 1160px;
  .player-wrap {
    .title {
      height: 50px;
      line-height: 50px;
      span {
        font-size: 24px;
        margin-right: 20px;
        color: #ff5c7c;
      }
      span:nth-child(1) {
        color: #00a1d6;
      }
    }

    .video-wrap {
      width: 100%;
      //   height: 540px;
      //   background: black;
      .video-box {
        margin: 0 auto;
        width: 1160px;
        height: 652px;

        .video {
          width: 100%;
          height: 100%;
          z-index: 9999;
        }
      }
    }
  }
}
</style>
