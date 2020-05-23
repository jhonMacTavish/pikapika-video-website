<template>
  <el-tabs v-model="activeName" @tab-click="handleClick">
    <el-tab-pane label="番剧榜" name="first">
      <div class="rankItem-box">
        <ul class="rank-list">
          <li class="rank-item" v-for="(item,index) in rankList" :key="item.v_id">
            <router-link
              :to="{path:'/playinfo',query:{t_id:item.t_id,v_id:item.v_id}}"
              target="_blank"
              tag="a"
              class="card-content"
            >
              <div class="link-div">
                <div class="num">{{index+1}}</div>
                <img :src="item.imgSrc" alt />
                <div class="desc">
                  <p class="title">{{item.name}}</p>
                  <span class="chapter">{{item.status==1?"更新至第":"全"}}{{item.episodes}}话</span>
                </div>
              </div>
            </router-link>
          </li>
        </ul>
      </div>
    </el-tab-pane>
    <el-tab-pane label="国漫榜" name="second">
      <div class="rankItem-box">
        <ul class="rank-list">
          <li class="rank-item" v-for="(item,index) in rankList" :key="item.v_id">
            <router-link
              :to="{path:'/playinfo',query:{t_id:item.t_id,v_id:item.v_id}}"
              target="_blank"
              tag="a"
              class="card-content"
            >
              <div class="link-div">
                <div class="num">{{index+1}}</div>
                <img :src="item.imgSrc" alt />
                <div class="desc">
                  <p class="title">{{item.name}}</p>
                  <span class="chapter">{{item.status==1?"更新至第":"全"}}{{item.episodes}}话</span>
                </div>
              </div>
            </router-link>
          </li>
        </ul>
      </div>
    </el-tab-pane>
    <el-tab-pane label="电影榜" name="third">
      <div class="rankItem-box">
        <ul class="rank-list">
          <li class="rank-item" v-for="(item,index) in rankList" :key="item.v_id">
            <router-link
              :to="{path:'/playinfo',query:{t_id:item.t_id,v_id:item.v_id}}"
              target="_blank"
              tag="a"
              class="card-content"
            >
              <div class="link-div">
                <div class="num">{{index+1}}</div>
                <img :src="item.imgSrc" alt />
                <div class="desc">
                  <p class="title">{{item.name}}</p>
                  <span class="chapter">{{item.status==1?"更新至第":"全"}}{{item.episodes}}话</span>
                </div>
              </div>
            </router-link>
          </li>
        </ul>
      </div>
    </el-tab-pane>
    <el-tab-pane label="影视榜" name="fourth">
      <div class="rankItem-box">
        <ul class="rank-list">
          <li class="rank-item" v-for="(item,index) in rankList" :key="item.v_id">
            <router-link
              :to="{path:'/playinfo',query:{t_id:item.t_id,v_id:item.v_id}}"
              target="_blank"
              tag="a"
              class="card-content"
            >
              <div class="link-div">
                <div class="num">{{index+1}}</div>
                <img :src="item.imgSrc" alt />
                <div class="desc">
                  <p class="title">{{item.name}}</p>
                  <span class="chapter">{{item.status==1?"更新至第":"全"}}{{item.episodes}}话</span>
                </div>
              </div>
            </router-link>
          </li>
        </ul>
      </div>
    </el-tab-pane>
  </el-tabs>
</template>

<script>
export default {
  name: "RankItem",
  data() {
    return {
      activeName: "first",
      rankList: [
        // {
        //   id: 1,
        //   imgSrc:
        //     "https://i0.hdslb.com/bfs/bangumi/image/d8a6884c2f839a5ffe5a0637608eec7910763411.png@113w_150h.webp",
        //   title: "公主连结 Re:Dive",
        //   chapter: 2
        // },
        // {
        //   id: 2,
        //   imgSrc:
        //     "https://i0.hdslb.com/bfs/bangumi/image/83ad052250e9a803e4ebaa47bef971cb079e0543.png@113w_150h.webp",
        //   title: "辉夜大小姐",
        //   chapter: 2
        // }
      ]
    };
  },
  computed: {},
  watch: {},
  async created() {
    await this.fetch("getBrank");
  },
  methods: {
    async fetch(path) {
      let res = await this.$http.get(path);
      this.rankList = res.data.list;
      this.rankList.length > 10 ? (this.rankList.length = 10) : "";
    },

    async handleClick() {
      console.log("this.activeName", this.activeName);
      switch (this.activeName) {
        case "first":
          await this.fetch("/getBrank");
          break;
        case "second":
          await this.fetch("/getGrank");
          break;
        case "third":
          await this.fetch("/getThrank");
          break;
        case "fourth":
          await this.fetch("/getFrank");
          break;
        default:
          break;
      }
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.rankItem-box {
  .rank-list {
    li.rank-item {
      margin: 0 auto;
      width: 1156px;
      border-bottom: 1px solid #e5e9ef;
      div,
      img {
        float: left;
      }

      div.link-div {
        padding: 20px;
        width: 100%;
        height: 100%;
      }

      div.num {
        margin-right: 30px;
        height: 120px;
        width: 40px;
        text-align: center;
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

      .VGA {
        color: #ff5c7c;
      }
    }

    li.rank-item:first-child {
      margin-top: 10px;
    }

    li.rank-item:hover {
      // border: 0px solid black;
      box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
      cursor: pointer;
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
