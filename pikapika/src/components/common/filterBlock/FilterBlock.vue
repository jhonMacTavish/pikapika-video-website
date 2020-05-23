<template>
  <div class="searchBar-box">
    <div class="filterBlock-box">
      <span class="type">{{searchType}}</span>
      <ul class="filter-item-box">
        <li
          class="filter-item"
          :class="{current:index+1==selected}"
          @click="setCurrent(index)"
          v-for="(item,index) in filterTags"
          :key="index"
        >{{item}}</li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "FilterBlock",
  props: {
    title: ""
  },
  data() {
    return {
      filterTags: [],
      selected: 1,
      searchType: "类型"
    };
  },
  computed: {
    searchParams() {
      return this.$store.getters.searchParams;
    }
  },
  watch: {
    async $route() {
      this.selected=1;
      await this.fetch();
    }
  },
  async created() {
    this.init();
    await this.fetch();
  },
  methods: {
    async fetch() {
      let title = this.title;
      let path = this.$route.params.id;
      if (title == "style") {
        this.searchType = "类型";
        let res = await this.$http.post(`/${path}s/type`);
        this.filterTags = res.data.list;
      }
      if (title == "quarter") {
        this.searchType = "季度";
        if (path == "bangumi")
          this.filterTags = ["全部", "1月", "4月", "7月", "10月"];
        else this.filterTags = ["全部"];
      }
      if (title == "tag") {
        this.searchType = "标签";
        this.filterTags = ["剧场版", "电影"];
      }
    },

    init() {
      let title = this.title;
      let path = this.$route.params.id;
      // console.log("path******", path);
      switch (title) {
        case "years":
          this.searchType = "时间";
          this.filterTags = [
            "全部",
            "2010",
            "2011",
            "2012",
            "2013",
            "2014",
            "2015",
            "2016",
            "2017",
            "2018",
            "2019",
            "2020"
          ];
          break;
        case "initials":
          this.searchType = "首字母";
          this.filterTags = [
            "全部",
            "A",
            "B",
            "C",
            "D",
            "E",
            "F",
            "G",
            "H",
            "I",
            "J",
            "K",
            "L",
            "M",
            "N",
            "O",
            "P",
            "Q",
            "R",
            "S",
            "T",
            "U",
            "V",
            "W",
            "X",
            "Y",
            "Z"
          ];
          break;
        default:
          break;
      }
    },
    async setCurrent(index) {
      console.log("searchParams", this.$store.getters.searchParams);
      this.selected = index+1;
      let searchParams = {};
      searchParams.key = this.title;
      searchParams.value =
        this.filterTags[index] == "全部" ? null : this.filterTags[index];

      this.$store.commit("UpdateSearchParams", searchParams);

      let path = this.$route.params.id;
      let res = await this.$http.post(`/${path}s/search`, this.searchParams);

      this.$store.commit("UpdateConmonList", res.data.list);
      // console.log("res", res.data.list);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.searchBar-box {
  font-size: 12px;
}

.searchBar-box::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}

.filterBlock-box {
  span.type {
    margin: 6px 0;
    width: 4%;
    height: 24px;
    line-height: 24px;
    display: block;
    float: left;
  }

  ul.filter-item-box {
    width: 95%;
    float: right;
    li.filter-item {
      display: inline-block;
      margin: 6px 0;
      margin-right: 6px;
      width: 46px;
      height: 24px;
      line-height: 24px;
      text-align: center;
      border-radius: 5px;
      cursor: pointer;
    }

    .current {
      // background: #ffb400;
      // background: #FF8EB3;
      background: #00a1d6;
      // color: white;
      // color: #00A1D6;
      color: white;
    }
  }
}
</style>
