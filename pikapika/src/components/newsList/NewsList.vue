<template>
  <div class="newsList-box">
    <NewsItem v-for="(item) in pageLists" :key="item.id" :text="item"/>
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
      newsList: [
        {
          id: 1,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 2,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 3,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 4,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 5,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 6,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 7,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 8,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 9,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 10,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 11,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        },
        {
          id: 12,
          title: "住手！之不是真正的打牌！",
          content:
            "开播之前我对此番还是挺感兴趣的，毕竟隔壁牌佬都已经退化成小学生了，如今能有人能教卡婊打牌还是挺好的。但是开播后迅速被满屏的尬点塞满了。草，生了出来。"
        }
      ],
      pageLists: []
    };
  },
  created() {
    this.handleCurrentChange(this.currentPage);
  },
  computed: {},
  watch: {},
  methods: {
    handleCurrentChange(val) {
      let pageLists = [];
      for (
        let i = 5 * (val - 1);
        i < (5 * val < this.newsList.length ? 5 * val : this.newsList.length);
        i++
      ) {
        pageLists.push(this.newsList[i]);
      }
      this.pageLists = pageLists;
      console.log(pageLists);

      const returnEle = document.querySelector("#navbar"); //window是将要跳转区域的id
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
