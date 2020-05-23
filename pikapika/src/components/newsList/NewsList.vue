<template>
  <div class="newsList-box">
    <NewsItem v-for="(item) in pageList" :key="item.id" :text="item" />
    <div class="window-pagination">
      <el-pagination
        @current-change="handleCurrentChange"
        :current-page.sync="currentPage"
        :page-size="5"
        layout="total, prev, pager, next"
        :total="newsList.length"
        background
      ></el-pagination>
    </div>
  </div>
</template>

<script>
import NewsItem from "../common/newsItem/NewsItem";

export default {
  name: "NewsList",
  data() {
    return {
      currentPage: 1,
      pageList: []
    };
  },
  created() {
    this.fetch();
  },
  computed: {
    newsList() {
      if (this.$route.path.indexOf("news") != -1) {
        return this.$store.getters.newsList;
      } else if (this.$route.path.indexOf("announce") != -1) {
        return this.$store.getters.announceList;
      }
    }
  },
  watch: {
    '$route'(to, from) {
      this.fetch();
    }
  },
  methods: {
    fetch() {
      this.handleCurrentChange(this.currentPage);
    },

    handleCurrentChange(val) {
      let pageList = [];
      console.log("this.newsList", this.newsList);
      for (
        let i = 5 * (val - 1);
        i < (5 * val < this.newsList.length ? 5 * val : this.newsList.length);
        i++
      ) {
        pageList.push(this.newsList[i]);
      }
      this.pageList = pageList;
      console.log(pageList);

      const returnEle = document.querySelector("#banner"); //window是将要跳转区域的id
      if (!!returnEle) {
        returnEle.scrollIntoView(true); // true 是默认的
      }
    }
  },
  components: { NewsItem }
};
</script>

<style lang='less' scoped>
.newsList-box {
  .window-pagination {
    display: inline-block;
    margin-bottom: 65px;
    margin-left: 50%;
    transform: translateX(-50%);
  }
}
</style>
