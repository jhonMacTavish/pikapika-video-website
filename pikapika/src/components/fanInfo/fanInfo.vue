<template>
  <div class="fanInfo-box">
    <div class="detail-info-box">
      <div class="detail-top">
        <div class="detail-top-con">
          <div class="poster-placeholder">
            <img src="https://ae01.alicdn.com/kf/Hfaa964dd207845769bb6be9624f70585T.jpg" alt />
          </div>
          <div class="txt-info-con">
            <div class="title">
              <h1>公主连结！Re:Dive</h1>
              <p>更新至03话</p>
            </div>
            <div class="publish-time">
              <span>2018年1月7日开播</span>
              <span>已完结, 全22话</span>
            </div>

            <div class="player">
              <span>声优</span>
              <span>市道真央</span>
              <span>立花理香</span>
              <span>伊藤美来</span>
            </div>

            <div class="type">
              <span>类型</span>
              <span>冒险</span>
              <span>奇幻</span>
              <span>战斗</span>
              <span>魔法</span>
            </div>

            <div class="intro">
              <p>
                <span>简介：</span>樱集齐了会给世间带来灾难的“库洛牌”，并用魔法的力量将它们变成了自己的牌。樱花盛开的4月，小樱升入了初中1年级。而后，小樱与曾返回香港的小狼重逢，并一起开心地去往学校。某个夜里，收集的牌出现了异常……而友枝町接连发生奇怪的事。小樱在梦中遇见的“钥匙”的指引下，再次开始收集卡片。这时，班里转来一个女孩子……
              </p>
            </div>
          </div>
        </div>
      </div>
      <div class="detail-bg">
        <div class="detail-bg-img"></div>
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
  computed: {},
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
        background-repeat: no-repeat;
        background-image: url(https://ae01.alicdn.com/kf/Hfaa964dd207845769bb6be9624f70585T.jpg);
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
              span {
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
