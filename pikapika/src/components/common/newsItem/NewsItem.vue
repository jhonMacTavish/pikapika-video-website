<template>
  <router-link :to="{name:'detail',query:{id:text.id}}">
    <div class="news-item-box">
      <div class="item-image"></div>
      <div class="item-content">
        <p class="title-box">
          <span class="title">{{text.title}}</span>
          <span class="publishDate">{{text.create_time}}</span>
        </p>
        <p class="artical">{{text.content}}</p>
      </div>
    </div>
  </router-link>
</template>

<script>
export default {
  name: "NewsItem",
  props: {
    text: {}
  },
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.news-item-box {
  margin-bottom: 40px;
  height: 88px;
  .item-image {
    float: left;
    width: 118px;
    height: 88px;
    border-radius: 5px;
    background: url(https://i0.hdslb.com/bfs/article/a82715287e363c1dffca002a18611ab2dfbd2d6e.png@292w_220h.webp);
    background-position: center;
    background-size: cover;
  }

  .item-content {
    float: right;
    width: 82%;
    height: 88px;

    .title-box {
      position: relative;
      font-size: 24px;
      font-weight: bold;

      span.publishDate {
        position: absolute;
        height: 32px;
        line-height: 32px;
        font-size: 16px;
        font-weight: normal;
        right: 0;
      }
    }

    .artical {
      line-height: 26px;
      padding: 2px 0;
      overflow: hidden;
      text-overflow: ellipsis;
      display: -webkit-box;
      -webkit-box-orient: vertical;
      -webkit-line-clamp: 2;
      line-height: 28px;
    }
  }
}

.news-item-box:hover {
  cursor: pointer;
  .item-content {
    .title {
      color: #00a1d6;
    }
  }
}
</style>
