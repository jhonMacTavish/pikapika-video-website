<template>
  <div class="leaderboard-box">
    <BlockHeader title="排行榜" />
    <div class="ledaerdata-box">
      <ul>
        <li v-for="(item,index) in leaderData" :key="index">
          <i class="rank-item">{{index+1}}</i>
          <router-link
            :to="{path:'/playinfo',query:{t_id:item.t_id,v_id:item.v_id}}"
            target="_blank"
            tag="a"
            class="card-content"
          >
            <p class="title">{{item.name}}</p>
            <span class="desc">{{item.status==1?"更新至":"全"}}{{item.episodes}}话</span>
          </router-link>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import BlockHeader from "../common/blockHeader/BlockHeader";

export default {
  name: "Leaderboard",
  data() {
    return {
      leaderData: [
        // { id: 1, title: "火影忍者", desc: "已完结" },
        // { id: 2, title: "辉夜大小姐", desc: "已完结" },
        // { id: 3, title: "百变小樱", desc: "已完结" },
        // { id: 4, title: "犬夜叉", desc: "已完结" },
        // {
        //   id: 5,
        //   title: "我的青春恋爱物语果然有问题 第三季",
        //   desc: "更新至1话"
        // },
        // { id: 6, title: "紫罗兰永恒花园", desc: "已完结" },
        // { id: 7, title: "吹响吧 上低音号！", desc: "已完结" },
        // { id: 8, title: "玉子市场", desc: "已完结" },
        // {
        //   id: 9,
        //   title: "关于我转生到一世界变成史莱姆这档事 第一季",
        //   desc: "已完结"
        // },
        // { id: 10, title: "overlord", desc: "已完结" }
      ]
    };
  },
  computed: {},
  watch: {},
  async created() {
    this.fetch();
  },
  methods: {
    async fetch() {
      let res = await this.$http.get("/getBGrank");

      this.leaderData = res.data.list;
    }
  },
  components: { BlockHeader }
};
</script>

<style lang='less' scoped>
.leaderboard-box {
  width: 313px;
  .ledaerdata-box {
    width: 100%;
    margin-top: 26px;

    ul {
      display: flex;
      height: 350px;
      width: 100%;
      overflow: auto;
      flex-direction: column;
      justify-content: space-between;
      li {
        position: relative;
        padding-left: 25px;
        overflow: hidden;
        font-size: 12px;

        i.rank-item {
          position: absolute;
          color: #fff;
          height: 18px;
          line-height: 18px;
          top: 0;
          left: 0;
          font-size: 12px;
          min-width: 12px;
          text-align: center;
          background-color: #b8c0cc;
          border-radius: 4px;
          padding: 0 3px;
          font-weight: bolder;
          font-style: normal;
        }

        a {
          position: relative;
          display: block;
          p.title {
            white-space: nowrap;
            text-overflow: ellipsis;
            max-width: 180px;
            line-height: 18px;
            vertical-align: top;
            color: #222;
            display: inline-block;
            overflow: hidden;
          }

          p.title:hover {
            color: #f25d8e;
          }

          span.desc {
            display: inline-block;
            vertical-align: top;
            color: #99a2aa;
            margin-left: 10px;
            line-height: 18px;
          }
        }
      }

      li:nth-child(-n + 3) {
        i.rank-item {
          background: #f25d8e;
        }
      }
    }
  }
}
</style>
