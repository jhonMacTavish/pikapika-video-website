<template>
  <div class="fanInfo-box">
    <div class="detail-info-box">
      <div class="detail-top">
        <div class="detail-top-con">
          <div class="poster-placeholder">
            <img :src="objectInfo.imgSrc" :title="objectInfo.name" />
          </div>
          <div class="txt-info-con">
            <div class="title">
              <h1>{{objectInfo.name}}</h1>
              <p v-if="!objectInfo.type_id==3">
                {{objectInfo.is_ended==1?"全":"更新至"}}
                {{objectInfo.episodes}}话
              </p>
            </div>
            <div class="publish-time">
              <span>{{objectInfo.playtime}} 开播</span>
              <span>{{objectInfo.is_ended==1?"已完结":"更新中"}}</span>
            </div>

            <p class="player">
              <!-- <span>主演</span> -->
              <ul>
                <li><span>主演</span></li>
                <li v-for="(actor,index) in (objectInfo.actors||'').split('、')"
                :key="index">{{actor}}</li>
              </ul>
              <!-- <span
                v-for="(actor,index) in (objectInfo.actors||'').split('、')"
                :key="index"
              >{{actor}}</span> -->
              <!-- <span>立花理香</span>
              <span>伊藤美来</span>-->
            </p>

            <p class="type">
              <span>类型</span>
              <span
                v-for="(style,index) in (objectInfo.style||'').split('、')"
                :key="index"
              >{{style}}</span>
              <!-- <span>冒险</span>
              <span>奇幻</span>
              <span>战斗</span>
              <span>魔法</span>-->
            </p>

            <div class="intro">
              <p>
                <span>简介</span>
                {{objectInfo.summary}}
              </p>
            </div>
            <div class="rate-wrap" @mouseenter="enterRate" @mouseleave="leaveRate">
              <span class="score" v-if="rate.avgScore">{{(rate.doubleScore==10?(rate.doubleScore-0.1):rate.doubleScore).toFixed(1)}}</span>
              <span class="noScore" v-else>暂无评分</span>
              <div class="rate">
                <el-rate
                  class="el-score"
                  disabled
                  v-model="rate.avgScore"
                  text-color="#ff9900"
                  score-template="{value}"
                ></el-rate>
                <div class="review" v-if="showRate" @click="dialogVisible=true">
                  <i class="el-icon-edit-outline"></i>
                  <span>我要评分</span>
                </div>
                <div class="reviewers" v-else>{{rate.reviewers}}人评</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="detail-bg">
        <div class="detail-bg-img" :style="`background-image: url(${objectInfo.imgSrc})`"></div>
      </div>
    </div>
    <el-dialog :visible.sync="dialogVisible" width="600px">
      <div class="dialog-content">
        <img
          class="media-img"
          src="//i0.hdslb.com/bfs/bangumi/image/83ad052250e9a803e4ebaa47bef971cb079e0543.png@100w_133h.png"
          alt
        />
        <div class="media-info">
          <p class="title">{{objectInfo.name}}</p>
          <p class="rate-tip">请发表你对这部作品的评分</p>
          <el-rate class="rate" v-model="rate.score" text-color="#ff9900" score-template="{value}"></el-rate>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="review">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "FanInfo",
  data() {
    return {
      rate: {
        score: 0,
        doubleScore: 0,
        avgScore: 0,
        reviewers: 0
      },

      showRate: false,
      dialogVisible: false,
      // objectInfo: {}
    };
  },
  computed: {
    objectInfo() {
      return this.$store.getters.objectInfo;
    },

    getParams() {
      return this.$store.getters.videoParams;
    }
  },
  watch: {},
  async created() {
    await this.fetch();
  },
  methods: {
    async getRate() {
      let { type_id, film_id } = this.objectInfo;
      let params = { type_id, film_id };
      const res = await this.$http.get(`/review/getRate`, { params });
      this.rate.avgScore = res.data.avgScore;
      this.rate.doubleScore = this.rate.avgScore * 2;
      this.rate.reviewers = res.data.reviewers;
    },

    enterRate() {
      this.showRate = !this.showRate;
    },

    leaveRate() {
      this.showRate = !this.showRate;
    },

    async review() {
      if (!localStorage.token) {
        this.$message({
          type: "error",
          message: "请先登录"
        });
        this.dialogVisible = false;
        return;
      }
      let { type_id, film_id } = this.objectInfo;
      let params = { type_id, film_id };
      params.score = this.rate.score;
      const res = await this.$http.post("/review", { params });
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
      await this.getRate();
      this.dialogVisible = false;
    },

    // async getFaninfo(path, params) {
    //   let res = await this.$http.get(`${path}/${params.film_id}`);
    //   // //console.log("objinfo", res.data[0]);
    //   //console.log("params", params);
    //   this.objectInfo = res.data[0];
    //   this.getRate();

    //   this.$store.commit("UpdateObjectInfo", this.objectInfo);

    //   res = await this.$http.get("/videos", { params });
    //   // //console.log("res", res.data.list);
    //   this.$store.commit("UpdateEpisodeList", res.data.list);
    // },

    async fetch() {
      // let params = this.$route.query;
      // if (params.type_id) {
      //   //console.log("UpdateVideoParams", params);
      //   this.$store.commit("UpdateVideoParams", params);
      // }

      // params = JSON.stringify(params) == "{}" ? this.getParams : params;
      // //console.log("params", params);
      // switch (params.type_id) {
      //   case "1":
      //     this.getFaninfo("/bangumis", params);
      //     // let res = await this.$http.get(`/bangumis/${params.film_id}`);
      //     // this.objectInfo = res.data[0];
      //     // this.$store.commit("UpdateObjectInfo", this.objectInfo);

      //     // let res = await this.$http.get("/videos", { params });
      //     // this.$store.commit("UpdateEpisodeList", res.data.list);
      //     break;
      //   case "2":
      //     this.getFaninfo("/guomans", params);

      //     break;
      //   case "3":
      //     this.getFaninfo("/theaters", params);
      //     break;
      //   case "4":
      //     this.getFaninfo("/filmtvs", params);
      //     break;
      //   default:
      //     break;
      // }
      // let res = await this.$http.get("/videos", { params });
      // //console.log("res", res.data.list);
      // this.$store.commit("UpdateEpisodeList", res.data.list);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.fanInfo-box {
  width: 100%;
  min-width: 1160px;

  .detail-info-box {
    width: 100%;
    height: 420px;
    position: relative;
    .detail-bg {
      z-index: -1;
      position: absolute;
      overflow: hidden;
      height: 420px;
      width: 100%;
      top: 0;
      .detail-bg-img {
        height: 420px;
        //   z-index: 10;
        // background-image: url(https://ae01.alicdn.com/kf/Hfaa964dd207845769bb6be9624f70585T.jpg);
        background-repeat: no-repeat;
        background-position: center;
        background-size: cover;
        filter: blur(40px);
      }

      .detail-bg-img::before {
        content: "";
        display: block;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.3);
        filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr=#48000000, endColorstr=#48000000);
        position: absolute;
        top: 0;
        left: 0;
        z-index: 11;
      }

      .detail-bg-img::after {
        content: "";
        display: block;
        clear: both;
        height: 0;
        visibility: hidden;
      }
    }

    .detail-top {
      // position: absolute;
      margin: 0 auto;
      width: 1160px;
      height: 420px;
      z-index: 9999;
      .detail-top-con {
        position: relative;
        padding: 38px 0;
        width: 1160px;
        height: 340px;
        margin: 0 auto;
        .poster-placeholder {
          width: 246px;
          float: left;
          margin-right: 30px;
          img {
            display: inline-block;
            border: 3px solid #efecef;
            // border: 3px solid red;
            border-radius: 5px;
            width: 240px;
            height: 334px;
            overflow: hidden;
          }
        }

        .txt-info-con {
          position: relative;
          width: 880px;
          height: 100%;
          float: right;
          color: white;
          .title {
            height: 56px;
            line-height: 50px;
            h1,
            p {
              display: inline-block;
            }
            h1 {
              margin-right: 10px;
            }
          }

          p {
            margin-top: 10px;
            span:first-child {
              border: 1px solid #00a1d6;
              padding: 0 2px;
              border-radius: 2px;
              // background: rgba(0, 0, 0, 0.1);
            }
          }

          .publish-time {
            margin-top: 10px;
            span {
              margin-right: 20px;
            }
          }

          .player {
            line-height: 26px;
            padding: 2px 0;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
            // span {
            //   margin-right: 16px;
            // }
            span:nth-child(1) {
              margin-right: 8px;
              color: #00a1d6;
            }

            ul{
              display: inline-block;
              li{
                margin-right: 16px;
                float: left;
              }
            }
          }

          .player::after {
            content: '';
            display: block;
            clear: both;
            visibility: hidden;
          }

          .type {
            line-height: 26px;
            padding: 2px 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            span {
              margin-right: 16px;
            }
            span:nth-child(1) {
              margin-right: 20px;
              color: #00a1d6;
            }
          }

          .intro {
            // position: absolute;
            // bottom: 0;
            p {
              line-height: 23px;
              padding: 2px 0;
              overflow: hidden;
              text-overflow: ellipsis;
              display: -webkit-box;
              -webkit-box-orient: vertical;
              -webkit-line-clamp: 4;
              span:nth-child(1) {
                margin-right: 20px;
                color: #00a1d6;
              }
            }
          }

          .rate-wrap {
            position: absolute;
            bottom: 10px;
            .score {
              display: inline-block;
              height: 36px;
              line-height: 36px;
              font-size: 36px;
              color: #ffa726;
              margin-right: 7px;
            }
            .noScore {
              display: inline-block;
              height: 36px;
              line-height: 18px;
              text-align: left;
              letter-spacing: 2px;
              width: 46px;
              margin-right: 7px;
            }
            .rate {
              display: inline-block;
              .review {
                font-size: 13px;
                .el-icon-edit-outline {
                  font-size: 16px;
                }
                span {
                  position: relative;
                  top: -1px;
                  vertical-align: bottom;
                }
              }

              .review:hover {
                cursor: pointer;
              }

              .reviewers {
                font-size: 13px;
              }
            }
          }
        }
      }

      // .detail-top-con::after {
      //   content: "";
      //   display: block;
      //   clear: both;
      //   visibility: hidden;
      // }
    }
  }

  .dialog-content {
    margin: -20px 10px 0 10px;
    height: 133px;
    font-family: Microsoft Yahei, Tahoma, Helvetica, Arial, "\5B8B\4F53",
      sans-serif;
    .media-img {
      display: inline-block;
      width: 100px;
      height: 133px;
      margin-right: 16px;
      border-radius: 5px;
    }
    .media-info {
      display: inline-block;
      position: absolute;
      .title {
        line-height: 50px;
        font-size: 20px;
        color: #222;
        letter-spacing: 0;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        font-weight: 600;
      }

      .rate-tip {
        // font-size: 20px;
        color: #222;
        margin-top: 10px;
        letter-spacing: 0;
      }

      .el-rate {
        margin-top: 20px;
        i,
        i.el-rate__icon,
        i.el-rate__icon::before {
          font-size: 24px !important;
        }
      }
    }
  }
}
</style>
