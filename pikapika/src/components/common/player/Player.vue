<template>
  <div class="player-box">
    <div id="player" class="player-wrap">
      <div class="title">
        <span>海贼王</span>
        <span>第{{item.b_episodes}}话</span>
      </div>
      <div class="video-wrap">
        <div class="video-box">
          <!-- <video class="video" controls preload="加载中">
            <source
              :src="item.r_address"
              type="video/mp4"
            />您的浏览器不支持 HTML5 视频,请更换浏览器。比如 Chrome 、 Firefox 等主流浏览器。
          </video>-->

          <video preload="加载中" autobuffer="true" data-setup="{}" class="video" controls>
            <source :src="item.r_address" type="video/mp4" />
            <div>
              <b>【错误】您使用的浏览器不支持HTML5视频...</b>
            </div>
          </video>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "",
  data() {
    return {
      item: ""
    };
  },
  mounted() {
    const returnEle = document.querySelector("#player"); //window是将要跳转区域的id
    if (!!returnEle) {
      returnEle.scrollIntoView(true); // true 是默认的
    }
  },
  created() {
    this.item = this.$route.params;
    console.log("route", this.item);
  },
  computed: {},
  watch: {},
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
        margin-right: 20px;
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
