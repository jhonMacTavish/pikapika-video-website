<template>
  <div class="footer-box">
    <div class="footer-content">
      <div class="frendly-link">
        <ul>
          <li>
            <span>友情链接：</span>
          </li>
          <li v-for="item in links" :key="item.id">
            <a :href="item.href" target="_black">{{item.title}}</a>
          </li>
        </ul>
        <p>本网站提供新影视资源均系收集各大网站，本网站只提供web页面浏览服务，并不提供影片资源存储，也不参与任何视频录制、上传</p>
        <p>
          若本站收集的节目无意侵犯了贵司版权，请给
          <span>981192661@qq.com</span>邮箱地址来信，我们将在第一时间删除相应资源
        </p>
        <p>
          Copyright © 2018-2019
          <span>www.pikapika.com</span>. All Rights Reserved .
        </p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Footer",
  data() {
    return {
      links: [
        { id: 1, title: "哔哩哔哩", href: "https://www.bilibili.com/" },
        { id: 2, title: "二次元圣地", href: "https://bbs.tohkalove.com/" },
        { id: 3, title: "Animex动漫社", href: "http://www.animetox.com/" }
      ]
    };
  },
  computed: {},
  watch: {},
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.footer-box {
  // position: absolute;
  // bottom: 0;
  margin-top: 80px;
  height: 186px;
  width: 100%;
  // background: url(../../../static/imgs/footer/footer.jpg);
  background: linear-gradient(105deg, #0ecad4, #0ecad4, #50e3c2);
  overflow: hidden;
  font-size: 12px;

  .footer-content {
    margin: 40px auto;
    height: 106px;
    width: 1160px;
    .frendly-link {
      ul li {
        float: left;
        margin-right: 10px;
        color: white;
        a {
          color: white;
        }

        a:hover {
          color: #f25d8e;
        }
      }

      ul::after {
        content: "";
        display: block;
        clear: both;
        visibility: hidden;
      }

      p {
        margin: 10px auto;
        text-align: center;
        color: white;
      }
    }
  }
}
</style>
