<template>
  <div>
    <!-- <iframe class="video-container" src="https://iqiyi.cdn9-okzy.com/share/73740ea85c4ec25f00f9acbd859f861d" frameborder="0">
      <p>Your browser does not support iframes.</p>
    </iframe>-->
    <!-- <video id="video" ref="video" controls="true" width="500px" height="400px">
      <p>Your browser does not support HTML5 video tag.</p>
    </video>-->
    <video
      id="video"
      ref="video"
      class="video-js vjs-default-skin vjs-big-play-centered"
      controls
      preload="auto"
    ></video>
  </div>
</template>

<script>
let Hls = require("hls.js");
export default {
  data() {
    return {
      value1: "2020-05-01",
      value2: "",
      dialogFormVisible: false,
      form: {
        name: "",
        region: "",
        date1: "",
        date2: "",
        delivery: false,
        type: [],
        resource: "",
        desc: ""
      },
      formLabelWidth: "120px",

      model: {
        b_style: ["校园", "日常", "恋爱"]
      },
      inputVisible: false,
      inputValue: ""
    };
  },
  mounted() {
    if (Hls.isSupported()) {
      let video = this.$refs.video;
      let hls = new Hls();
      hls.loadSource(
        "https://youku.cdn4-okzy.com/20200112/3776_b17033ba/index.m3u8"
      );
      hls.attachMedia(video);
      hls.on(Hls.Events.MANIFEST_PARSED, () => {
        console.log("加载成功");
        this.$refs.video.play();
      });
      hls.on(Hls.Events.ERROR, (event, data) => {
        // console.log(event, data);
        // 监听出错事件
        console.log("加载失败");
      });
    } else if (this.$refs.video.canPlayType("application/vnd.apple.mpegurl")) {
      this.$refs.video.src =
        "https://video-dev.github.io/streams/x36xhzz/x36xhzz.m3u8";
      this.$refs.video.addEventListener("loadedmetadata", function() {
        this.$refs.video.play();
      });
    }
  },
  methods: {
    handleClose(tag) {
      this.model.b_style.splice(this.model.b_style.indexOf(tag), 1);
    },

    showInput() {
      this.inputVisible = true;
      this.$nextTick(_ => {
        this.$refs.saveTagInput.$refs.input.focus();
      });
    },

    handleInputConfirm() {
      let inputValue = this.inputValue;
      if (inputValue) {
        this.model.b_style.push(inputValue);
      }
      this.inputVisible = false;
      this.inputValue = "";
    }
  }
};
</script>

<style lang="less" scoped>
.video-container {
  width: 400px;
  height: 300px;
}
</style>