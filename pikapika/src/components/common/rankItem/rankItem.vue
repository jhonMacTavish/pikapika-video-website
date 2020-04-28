<template>
  <div class="rankItem-box">
    <ul class="rank-list">
      <li class="rank-item" v-for="item in rankList" :key="item.id">
        <div class="num">{{item.id}}</div>
        <img :src="item.imgSrc" alt />
        <div class="desc">
          <p class="title">{{item.title}}</p>
          <span class="chapter">更新至第{{item.chapter}}话</span>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "RankItem",
  data() {
    return {
      rankList: [
        {
          id: 1,
          imgSrc:
            "https://i0.hdslb.com/bfs/bangumi/image/d8a6884c2f839a5ffe5a0637608eec7910763411.png@113w_150h.webp",
          title: "公主连结 Re:Dive",
          chapter: 2
        },
        {
          id: 2,
          imgSrc:
            "https://i0.hdslb.com/bfs/bangumi/image/83ad052250e9a803e4ebaa47bef971cb079e0543.png@113w_150h.webp",
          title: "辉夜大小姐",
          chapter: 2
        }
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
.rankItem-box {
  .rank-list {
    li.rank-item {
      padding: 20px 0;
      padding-left: 20px;
      width: 1160px;
      border-bottom: 1px solid #e5e9ef;
      div,
      img {
        float: left;
      }

      div.num {
        margin-right: 30px;
        height: 120px;
        line-height: 120px;
        color: #b8c0cc;
        font-size: 36px;
      }

      img {
        margin-right: 20px;
        width: 90px;
        height: 120px;
        border-radius: 5px;
      }

      .title {
        height: 42px;
        line-height: 42px;
        font-size: 18px;
        font-weight: 700;
      }

      .chapter {
        font-size: 12px;
        color: #99a2aa;
      }
    }

    li.rank-item:hover{
      box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
    }

    li.rank-item::after {
      content: "";
      display: block;
      clear: both;
      visibility: hidden;
    }
  }
}
</style>
