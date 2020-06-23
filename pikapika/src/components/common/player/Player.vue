<template>
  <div class="player-box">
    <div id="player" class="player-wrap">
      <div class="title">
        <span>{{objectInfo.name}}</span>
        <span>第 {{episode}} 话</span>
        <span>{{item.video_name}}</span>
      </div>
      <div class="video-wrap">
        <video
          ref="video"
          preload="加载中"
          autobuffer="true"
          data-setup="{}"
          width="1160"
          height="653"
          controls
        >
          <source type="video/mp4" src="horse.mp3" />
          <div>
            <b>【错误】您使用的浏览器不支持HTML5视频...</b>
          </div>
        </video>
        <!-- <div class="video-box">
          <video class="video" controls preload="加载中" width="1160px">
          <source type="video/mp4" />您的浏览器不支持 HTML5 视频,请更换浏览器。比如 Chrome 、 Firefox 等主流浏览器。
          </video>
          <el-card class="box-card" body-style="padding:5px;background:rgba(0,0,0,0.2)">
          </el-card>
          <div class="pause" v-if="pause" @click="play"></div>
          <video
            id="video"
            ref="video"
            width="1160px"
            class="video-js vjs-default-skin vjs-big-play-centered myvideo"
            controls
            preload="auto"
          ></video>
        </div>-->
      </div>
      <iframe
        width="1160px"
        height="653px"
        allowfullscreen="true"
        webkitallowfullscreen="true"
        mozallowfullscreen="true"
        class="myframe"
        :src="item.src"
        frameborder="0"
      >
        <p>Your browser does not support iframes.</p>
      </iframe>
    </div>
  </div>
</template>

<script>
let Hls = require("hls.js");
export default {
  name: "",
  props: {
    type_id: {
      type: String,
      default: "1"
    },
    film_id: {
      type: String,
      default: "1"
    },
    epIndex: {
      type: String,
      default: "1"
    },
    episode: {
      type: String,
      default: "1"
    }
  },
  data() {
    return {
      pause: true,
      item: {},
      index: 0
    };
  },
  async mounted() {
    const returnEle = document.querySelector("#player"); //window是将要跳转区域的id
    if (!!returnEle) {
      returnEle.scrollIntoView(true); // true 是默认的
    }

    let params = this.getParams;
    let res = await this.$http.get("/videos", { params });
    this.$store.commit("UpdateEpisodeList", res.data.list);

    //console.log("epIndex", this.epIndex);
    this.index = this.epIndex;
    --this.index;
    //console.log("index", this.index);
    this.item = this.$store.getters.episodeList[this.index];
    // if (Hls.isSupported()) {
    //   let video = this.$refs.video;
    let iframe = document.getElementsByTagName("iframe")[0];
    // let video = iframe.contentWindow.document.body.getElementsByTagName('video')[0];
    // let video = iframe.contentWindow.document.body;
    // //console.log("video", video);
    // video.addEventListener("play", () => {
    //   this.pause = false;
    // });
    // video.addEventListener("pause", () => {
    //   this.pause = true;
    // });
    //   let hls = new Hls();
    //   hls.loadSource(this.item.src);
    //   hls.attachMedia(video);
    //   hls.on(Hls.Events.MANIFEST_PARSED, () => {
    //     //console.log("加载成功");
    //     // this.$refs.video.play();
    //   });
    //   hls.on(Hls.Events.ERROR, (event, data) => {
    //     //console.log(event, data);
    //     // 监听出错事件
    //     //console.log("加载失败");
    //   });
    // } else if (this.$refs.video.canPlayType("application/vnd.apple.mpegurl")) {
    //   this.$refs.video.src =
    //     "https://video-dev.github.io/streams/x36xhzz/x36xhzz.m3u8";
    //   this.$refs.video.addEventListener("loadedmetadata", function() {
    //     this.$refs.video.play();
    //   });
    // }
  },
  // async created() {
  //   //console.log("createPlayer");
  //   // this.item = this.$route.query;
  //   // //console.log("playerRoute", this.item);
  //   let params = this.getParams;
  //   let res = await this.$http.get("/videos", { params });
  //   this.$store.commit("UpdateEpisodeList", res.data.list);

  //   //console.log("id", this.id);
  //   this.index = this.id;
  //   --this.index;
  //   //console.log("index", this.index);
  //   this.item = this.$store.getters.episodeList[this.index];
  //   //console.log("this.item", this.item);
  //     //console.log("this.item.src222222", this.item.src);

  //   // this.item = this.$store.getters.episodeList[this.index];
  //   // this.$refs.video.src = this.item.src;
  //   // this.$refs.video.play();
  // },
  computed: {
    objectInfo() {
      return this.$store.getters.objectInfo;
    },

    getParams() {
      return this.$store.getters.videoParams;
    }
  },
  watch: {
    epIndex(newV, olV) {
      if (newV != olV) {
        this.index = this.epIndex;
        --this.index;
        this.item = this.$store.getters.episodeList[this.index];

        this.$refs.video.src = this.item.src;
        this.$refs.video.pause();
      }
      
    }
  },
  methods: {
    play() {
      this.pause = !this.pause;
      if (this.pause) {
        this.$refs.video.pause();
      } else {
        this.$refs.video.play();
      }
    }
  },
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
        font-size: 18px;
        margin-right: 20px;
        color: #00a1d6;
      }
      span:nth-child(1) {
        font-size: 24px;
        color: #39c5bb;
      }

      span:nth-child(2) {
        color: #ff5c7c;
      }
    }

    .video-wrap {
      z-index: -1;
      position: absolute;
      margin: 0 auto;
      width: 1160px;
      height: 653px;
      // background: rgba(60, 179, 113, 0.3);
      //   height: 540px;
      //   background: black;
      // .video-box {
      //   position: absolute;
      //   margin: 0 auto;
      //   width: 1160px;
      //   height: 653px;
      //   background: rgba(60, 179, 113, 0.3);
      //   // height: 652px;
      //   .myvideo {
      //     cursor: pointer;
      //   }
      //   .pause {
      //     cursor: pointer;
      //     position: absolute;
      //     width: 218px;
      //     height: 180px;
      //     left: 50%;
      //     top: 50%;
      //     transform: translateX(-50%) translateY(-50%);
      //     background: url(../../../../static/imgs/play/play.png);
      //     background-position: center;
      //     background-repeat: no-repeat;
      //     opacity: 0.6;
      //     z-index: 2020;
      //   }
      //   .video {
      //     position: absolute;
      //     z-index: 1;
      //   }
      // }
    }

    .myframe {
      z-index: 2020;
    }
  }
}
</style>
