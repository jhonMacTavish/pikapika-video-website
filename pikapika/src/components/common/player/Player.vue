<template>
  <div class="player-box">
    <div id="player" class="player-wrap">
      <div class="title">
        <span>海贼王</span>
        <span>第24话</span>
      </div>
      <div class="video-wrap">
        <div class="video-box">
          <video class="video" controls preload="加载中">
            <source
              src="http://183.36.112.69/vmtt.tc.qq.com/1098_9a24f4c75f358dd2700441de94988d20.f0.mp4?vkey=BEE0CD75DA93BA97904E0A82657FD7D29F7CB80BAB1C47B6596DC12458B760A49BBF200CCA1AD4ACAEE33A42BDC2C3828818BDA57AC66F0D8C87769317BF6487B6964CAE553263BA074767E30553BB71C52DB52474E680AB"
              type="video/mp4"
            />您的浏览器不支持 HTML5 视频,请更换浏览器。比如 Chrome 、 Firefox 等主流浏览器。
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
    return {};
  },
  mounted() {
    const returnEle = document.querySelector("#player"); //window是将要跳转区域的id
    if (!!returnEle) {
      returnEle.scrollIntoView(true); // true 是默认的
    }
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
