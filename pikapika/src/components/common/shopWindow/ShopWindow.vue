<template>
  <div class="shopWindow-box">
    <div id="window" class="window-orderType">
      <span
        :class="{current:item.id==selected}"
        @click="setCurrent(item.id)"
        v-for="item in orderTypes"
        :key="item.id"
      >{{item.title}}</span>
    </div>
    <div v-if="pageList.length>0">
      <div class="window-body">
        <Card v-for="(item,index) in pageList" :key="index" :listItem="item" />
      </div>
      <div class="window-pagination">
        <el-pagination
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage"
          :page-size="24"
          layout="total, prev, pager, next"
          :total="totalItems"
          background
        ></el-pagination>
      </div>
    </div>
    <div v-else class="no-data-wrap">
      <span>没有这样的番剧哦~</span>
      <el-button type="primary" class="reset">重置筛选</el-button>
    </div>
  </div>
</template>

<script>
import Card from "../card/Card";

export default {
  name: "ShopWindow",
  data() {
    return {
      orderTypes: [
        {
          id: 1,
          title: "播放数量"
        },
        {
          id: 2,
          title: "播放时间"
        }
        // {
        //   id: 3,
        //   title: "更新时间"
        // }
      ],
      selected: 1,
      currentPage: 1,
      pageList: [],
      pathArr: ["bangumi", "guoman", "theater", "filmtv"]
    };
  },
  async created() {
    // console.log("route", this.$route);
    await this.fetch();
  },
  mounted() {
    // console.log(this);
  },
  computed: {
    serhResultList() {
      return this.$store.getters.serhResultList;
    },

    conmonList() {
      return this.$store.getters.conmonList;
    },

    totalItems() {
      return this.$store.getters.conmonList.length;
    }
  },
  watch: {
    async $route(to, from) {
      // console.log("to.params.id", to.params.id);
      // console.log("this.pathArr.indexOf(to.params.id)", this.pathArr.indexOf(to.params.id));
      if (this.pathArr.indexOf(to.params.id)!=-1) {
        console.log("run");
        this.currentPage = 1;
        await this.fetch();
      }
    },

    conmonList(newV, oldV) {
      if (newV != oldV) {
        this.currentPage = 1;
        this.handleCurrentChange(this.currentPage);
      }
    }
  },
  methods: {
    async fetch() {
      let path = this.$route.params.id;
      let res = await this.$http.get(`/${path}s`);
      this.$store.commit("UpdateConmonList", res.data.list);
      this.handleCurrentChange(this.currentPage);
      // console.log("conmonList", this.conmonList);
      // console.log("res", res.data.list);
    },

    setCurrent(index) {
      this.selected = index;
    },

    handleCurrentChange(val) {
      let pageList = [];
      for (
        let i = 24 * (val - 1);
        i < (24 * val < this.totalItems ? 24 * val : this.totalItems);
        i++
      ) {
        pageList.push(this.conmonList[i]);
      }
      this.pageList = pageList;

      // const returnEle = document.querySelector("#banner"); //window是将要跳转区域的id
      // if (!!returnEle) {
      //   returnEle.scrollIntoView(true); // true 是默认的
      // }
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    }
  },
  components: { Card }
};
</script>

<style lang='less' scoped>
.shopWindow-box {
  margin-top: 0px;
  width: 100%;
  .window-orderType {
    margin-top: 30px;
    width: 100%;
    height: 100%;
    span {
      display: inline-block;
      margin-right: 30px;
      cursor: pointer;
    }

    .current {
      padding-bottom: 6px;
      border-bottom: 4px solid #ffb400;
    }
  }

  .window-body {
    width: 100%;

    div.card-box:nth-child(6n + 0) {
      margin-right: 0px;
    }
  }

  .window-body::after {
    content: "";
    display: block;
    clear: both;
    visibility: hidden;
  }

  .window-pagination {
    display: inline-block;
    margin-top: 30px;
    margin-left: 50%;
    transform: translateX(-50%);
  }

  .no-data-wrap {
    padding-top: 320px;
    position: relative;
    width: 100%;
    text-align: center;
    background-repeat: no-repeat;
    background-position: center;
    background-image: url(//s1.hdslb.com/bfs/static/bangumi-index/asserts/bgm-nodata-filter.png);
    span {
      display: block;
      height: 20px;
      line-height: 20px;
      font-size: 14px;
      color: #99a2aa;
      text-align: center;
    }
    .reset {
      width: 160px;
      margin: 20px 0;
    }
  }
}
</style>
