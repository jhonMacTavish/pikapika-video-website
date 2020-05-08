<template>
  <div class="fanInfo-box">
    <div class="detail-info-box">
      <div class="detail-top">
        <div class="detail-top-con">
          <div class="poster-placeholder">
            <img
              :src="objectInfo.t_id==1?
                objectInfo.b_imgSrc:objectInfo.t_id==2?
                objectInfo.g_imgSrc:objectInfo.t_id==3?
                objectInfo.th_imgSrc:objectInfo.f_imgSrc"
              :title="objectInfo.b_name"
            />
          </div>
          <div class="txt-info-con">
            <div class="title">
              <h1>
                {{objectInfo.t_id==1?
                objectInfo.b_name:objectInfo.t_id==2?
                objectInfo.g_name:objectInfo.t_id==3?
                objectInfo.th_name:objectInfo.f_name}}
              </h1>
              <p>
                {{(objectInfo.t_id==1?
                objectInfo.b_status:objectInfo.t_id==2?
                objectInfo.g_status:objectInfo.t_id==3?
                objectInfo.th_status:objectInfo.f_status)==2?"全":"更新至"}}
                {{objectInfo.t_id==1?
                objectInfo.b_episodes:objectInfo.t_id==2?
                objectInfo.g_episodes:objectInfo.t_id==3?
                objectInfo.th_episodes:objectInfo.f_episodes}}话
              </p>
            </div>
            <div class="publish-time">
              <span>
                {{objectInfo.t_id==1?
                objectInfo.b_playtime:objectInfo.t_id==2?
                objectInfo.g_playtime:objectInfo.t_id==3?
                objectInfo.th_playtime:objectInfo.f_playtime}} 开播
              </span>
              <span>
                {{(objectInfo.t_id==1?
                objectInfo.b_status:objectInfo.t_id==2?
                objectInfo.g_status:objectInfo.t_id==3?
                objectInfo.th_status:objectInfo.f_status)==1?"更新中":"已完结"}}
              </span>
            </div>

            <div class="player">
              <span>主演</span>
              <span
                v-for="(actor,index) in ((objectInfo.t_id==1?
                objectInfo.b_actors:objectInfo.t_id==2?
                objectInfo.g_actors:objectInfo.t_id==3?
                objectInfo.th_actors:objectInfo.f_actors)||'').split('、')"
                :key="index"
              >{{actor}}</span>
              <!-- <span>立花理香</span>
              <span>伊藤美来</span>-->
            </div>

            <div class="type">
              <span>类型</span>
              <span
                v-for="(style,index) in ((objectInfo.t_id==1?
                objectInfo.b_style:objectInfo.t_id==2?
                objectInfo.g_style:objectInfo.t_id==3?
                objectInfo.th_style:objectInfo.f_styles)||'').split('、')"
                :key="index"
              >{{style}}</span>
              <!-- <span>冒险</span>
              <span>奇幻</span>
              <span>战斗</span>
              <span>魔法</span>-->
            </div>

            <div class="intro">
              <p>
                <span>简介：</span>
                {{objectInfo.t_id==1?
                objectInfo.b_summary:objectInfo.t_id==2?
                objectInfo.g_summary:objectInfo.t_id==3?
                objectInfo.th_summary:objectInfo.f_summary}}
              </p>
            </div>
          </div>
        </div>
      </div>
      <div class="detail-bg">
        <div
          class="detail-bg-img"
          :style="`background-image: url(${objectInfo.t_id==1?
                objectInfo.b_imgSrc:objectInfo.t_id==2?
                objectInfo.g_imgSrc:objectInfo.t_id==3?
                objectInfo.th_imgSrc:objectInfo.f_imgSrc})`"
        ></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "FanInfo",
  data() {
    return {};
  },
  computed: {
    objectInfo() {
      return this.$store.getters.objectInfo;
    }
  },
  watch: {},
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.fanInfo-box {
  .detail-info-box {
    margin-left: -180px;
    margin-right: -180px;
    position: relative;
    .detail-bg {
      overflow: hidden;
      //   position: absolute;
      height: 420px;
      width: 100%;
      //   background: sienna;

      .detail-bg-img {
        margin-left: -5%;
        width: 110%;
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
      position: absolute;
      width: 100%;
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
            border: 3px solid #efecef;
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

          .publish-time {
            margin-top: 10px;
            span {
              margin-right: 20px;
            }
          }

          .player {
            margin-top: 20px;
            span {
              margin-right: 20px;
            }
            span:nth-child(1) {
              color: #ff9900;
            }
          }

          .type {
            margin-top: 10px;
            span {
              margin-right: 20px;
            }
            span:nth-child(1) {
              color: #ff9900;
            }
          }

          .intro {
            position: absolute;
            bottom: 0;
            p {
              line-height: 30px;
              span:nth-child(1) {
                color: #ff9900;
              }
            }
          }
        }
      }

      .detail-top-con::after {
        content: "";
        display: block;
        clear: both;
        visibility: hidden;
      }
    }
  }
}
</style>
