<template>
  <div class="filterBlock-box">
    <span class="type">类型</span>
    <ul class="filter-item-box">
      <li class="filter-item" :class="{current:item.id==selected}" @click="setCurrent(item.id)" v-for="item in filterTags" :key="item.id">{{item.title}}</li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "FilterBlock",
  data() {
    return {
      filterTags: [
        {
          id: 1,
          title: "热血"
        },
        {
          id: 2,
          title: "冒险"
        },
        {
          id: 3,
          title: "搞笑"
        },
        {
          id: 4,
          title: "运动"
        },
        {
          id: 5,
          title: "竞技"
        },
        {
          id: 6,
          title: "装逼"
        },
        {
          id: 7,
          title: "剧情"
        },
        {
          id: 8,
          title: "穿越"
        },
        {
          id: 9,
          title: "青春"
        },
        {
          id: 10,
          title: "小说改"
        },
        {
          id: 11,
          title: "后宫"
        },
        {
          id: 12,
          title: "校园"
        },
        {
          id: 13,
          title: "励志"
        },
        {
          id: 14,
          title: "恋爱"
        },
        {
          id: 15,
          title: "热血"
        },
        {
          id: 16,
          title: "冒险"
        },
        {
          id: 17,
          title: "搞笑"
        },
        {
          id: 18,
          title: "运动"
        },
        {
          id: 19,
          title: "竞技"
        },
        {
          id: 20,
          title: "装逼"
        },
        {
          id: 21,
          title: "剧情"
        },
        {
          id: 22,
          title: "穿越"
        },
      ],
      selected: 1
    };
  },
  computed: {},
  watch: {},
  methods: {
    setCurrent(index){
      this.selected=index;
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
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

    .current{
      background: #FFB400;
      color: white;
    }
  }
}
</style>
