<template>
  <div class="news-box">
    <div class="news-wrap">
      <div class="newsDetail-box">
        <div class="news-header">
          <p class="news-title">{{detail(index).title}}</p>
          <p class="publish-info">
            <span>{{detail(index).editor}}</span>
            <span>{{detail(index).create_time}}</span>
          </p>
        </div>
        <div class="news-content">
          <p>{{detail(index).content}}</p>
        </div>
      </div>
    </div>
    <!-- <div class="rank-wrap">
      <Leaderboard />
    </div>-->
  </div>
</template>

<script>
import Leaderboard from "../leaderboard/Leaderboard";
import NewsItem from "../common/newsItem/NewsItem";

export default {
  name: "NewsDetail",
  data() {
    return {
      index: 0
    };
  },
  created() {},
  computed: {},
  watch: {},
  methods: {
    detail(index) {
      if (this.$route.path.indexOf("news")!=-1) {
        return this.$store.getters.newsList[index];
      }else if(this.$route.path.indexOf("announce")!=-1){
        return this.$store.getters.announceList[index];
      }
    }
  },
  components: { Leaderboard, NewsItem },
  beforeRouteEnter(to, from, next) {
    next(vm => {
      vm.index = vm.$route.query.id - 1;
    });
  }
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

      .news-content {
        p {
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
