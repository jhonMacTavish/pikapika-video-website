<template>
  <div class="page-content">
    <div class="news-wrap">
      <router-view />
    </div>
    <div class="rank-wrap">
      <Leaderboard />
    </div>
  </div>
</template>

<script>
import Leaderboard from "../leaderboard/Leaderboard";
import NewsItem from "../common/newsItem/NewsItem";

export default {
  name: "News",
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {},
  components: { Leaderboard, NewsItem }
};
</script>
<style lang='less' scoped>
.page-content {
  .news-wrap {
    float: left;
    width: 70%;
  }

  .rank-wrap {
    margin-top: -40px;
    float: right;
  }
}

.page-content::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}
</style>
