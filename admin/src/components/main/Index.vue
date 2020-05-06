<template>
  <div class="container">
    <div class="index" :style="`background: url(${imgurl})`">
      <div class="title">
        <span class="first">Pi</span>
        <span class="second">ka</span>
        <span class="first">Pi</span>
        <span class="second">ka</span>
        <span>后台管理系统</span>
        <div class="hitokoto">
          <p>{{this.hitokoto.hitokoto}}</p>
          <p>——{{this.hitokoto.from}}</p>
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
      imgurl: "",
      hitokoto: {},
      imgs: [
        {
          imgurl:
            "https://tvax3.sinaimg.cn/large/0072Vf1pgy1foxk7r8ic6j31hc0u0k7b.jpg"
        },
        {
          imgurl:
            "https://tvax4.sinaimg.cn/large/0072Vf1pgy1fodqnqq0fsj31js0tj4qp.jpg"
        },
        {
          imgurl:
            "https://tvax1.sinaimg.cn/large/006ZFECEgy1fr1x6fq53hj31hc0u0h87.jpg"
        },
        {
          imgurl:
            "https://tvax1.sinaimg.cn/large/7f0c40d4gy1fqbg4jwszkj21hc0u0q7z.jpg"
        },
        {
          imgurl:
            "https://tvax4.sinaimg.cn/large/0072Vf1pgy1foxk7mecohj31hc0u048p.jpg"
        },
        {
          imgurl:
            "https://tvax3.sinaimg.cn/large/0072Vf1pgy1foxk3qdi4cj31kw0w0kh2.jpg"
        },
        {
          imgurl:
            "https://tvax4.sinaimg.cn/large/0072Vf1pgy1foxkc3khj2j31kw0w0x48.jpg"
        },
        {
          imgurl:
            "https://tvax3.sinaimg.cn/large/0072Vf1pgy1foxkeyolv6j31kw0w07v2.jpg"
        },
        {
          imgurl:
            "https://api.dongmanxingkong.com/suijitupian/acg/1080p/index.php"
        },
        {
          imgurl:
            "https://tvax4.sinaimg.cn/large/0072Vf1pgy1foxk6ybqjfj31hc0u047b.jpg"
        }
      ]
    };
  },
  computed: {},
  watch: {},
  created() {
    this.fetch();
  },

  mounted() {
    // if(this.imgurl){
    //   this.imgurl='https://tvax4.sinaimg.cn/large/0072Vf1pgy1fodqnqq0fsj31js0tj4qp.jpg';
    // }
  },
  methods: {
    async fetch() {
      let resI = await this.$http.get("/image");
      console.log("image", resI);
      this.imgurl = resI.data.imgurl;

      let resW = await this.$http.get("/hotokoto");
      console.log("hotokoto", resW);
      this.hitokoto = resW.data;
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.container {
  height: 100%;
  width: 100%;
  position: relative;
  .index {
    position: relative;
    height: 100%;
    width: 100%;
    overflow: auto;
    // margin-right: -17px;
    background: url(https://tvax1.sinaimg.cn/large/006ZFECEgy1fr1x6hpz74j31hc0u0x6i.jpg);
    background-repeat: no-repeat!important;
    background-position: center!important;
    background-size: cover!important;
    .title {
      // width: 600px;
      padding: 30px;
      width: 367px;
      display: inline-block;
      position: absolute;
      font-size: 2em;
      top: 50%;
      left: 50%;
      transform: translateX(-50%) translateY(-50%);
      border-radius: 5px;
      // background: rgba(0, 0, 0, 0.1);
      // border: 2px solid rgba(0, 0, 0, 0.1);
      // box-shadow: 0 0 4px 1px rgba(0, 0, 0, 0.1);
      background: rgba(255, 255, 255, 0.5);
      border: 2px solid rgba(255, 255, 255, 0.5);
      box-shadow: 0 0 4px 1px rgba(255, 255, 255, 0.5);

      .first {
        font-weight: bold;
        color: #00a1d6;
      }

      .second {
        font-weight: bold;
        color: #ff5c7c;
      }

      span {
        font-weight: normal;
      }

      .hitokoto {
        font-size: 12px !important;
        font-weight: normal;
      }
    }
  }
  .index::before {
    content: "";
    display: block;
    position: absolute;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.3);
    filter: blur(1px);
  }
}
</style>
