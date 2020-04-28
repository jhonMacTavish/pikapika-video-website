<template>
  <div class="news-box">
    <div class="news-wrap">
      <div class="newsDetail-box">
        <div class="news-header">
          <p class="news-title">住手！之不是真正的打牌！</p>
          <p class="publish-info">
            <span>动漫杂谈</span>
            <span>2020-4-21 18:00:24</span>
          </p>
        </div>
        <div class="news-content">
          <p>原域名www.bimibimi.tv已被墙，做了处理暂时性可访问，5月4日后切断跳转，网址替换为www.bimibimi.me；请牢记！！！</p>
        </div>
      </div>
    </div>
    <!-- <div class="rank-wrap">
      <Leaderboard />
    </div> -->
  </div>
</template>

<script>
import Leaderboard from "../leaderboard/Leaderboard";
import NewsItem from "../common/newsItem/NewsItem";

export default {
  name: "NewsDetail",
  data() {
    return {};
  },
  created(){
    console.log(this.$route);
  },
  computed: {},
  watch: {},
  methods: {},
  components: { Leaderboard, NewsItem }
};
</script>
<style lang='less' scoped>
.news-box {
  width: 100%;
  .news-wrap {
    float: left;
    // width: 70%;
    .newsDetail-box {
      p {
        margin: 10px 0;
      }

      .news-header {
        p.news-title {
          font-size: 36px;
          font-weight: 800;
        }

        p.publish-info {
          span {
            display: inline-block;
            margin-right: 50px;
            color: #b8c0cc;
            font-size: 12px;
          }
        }
      }

      .news-content{
        p{
          text-indent: 2em;
          line-height: 30px;
        }
      }
    }
  }

  .rank-wrap {
    margin-top: -40px;
    float: right;
  }
}

.news-box::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}
</style>
