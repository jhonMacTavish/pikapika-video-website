<template>
  <div id="comment" class="comment-box">
    <div class="tip">评论</div>
    <div class="add-comment-wrap">
      <div class="avatar">
        <img :src="avtar" alt />
      </div>
      <div class="text-area">
        <el-input
          :disabled="!logged"
          type="textarea"
          v-model="textarea"
          :rows="3"
          :cols="147"
          :maxlength="430"
          size="mini"
          :placeholder="logged?'请自觉遵守物联网相关的政策法规，严禁发布色情、暴力、反动的言论':'请先登录'"
        ></el-input>
      </div>
      <div class="publish-button">
        <!-- <el-button type="primary" class="button-style" :disabled="true">主要按钮</el-button> -->
        <button class="button-style" :disabled="!logged" @click="post">发表评论</button>
      </div>
    </div>
    <div>
      <CommentItem v-for="(item,index) in pageList" :key="index" :listItem="item" />
      <div class="window-pagination">
        <el-pagination
          @current-change="handleCurrentChange"
          :current-page.sync="currentPage"
          :page-size="5"
          layout="total, prev, pager, next"
          :total="totalItems"
          background
        ></el-pagination>
      </div>
    </div>
  </div>
</template>

<script>
import CommentItem from "../common/commentItem/CommentItem";

export default {
  name: "Comment",
  data() {
    return {
      textarea: "",
      currentPage: 1,
      pageList: [],
      avtar: "",
      user: {}
    };
  },
  created() {
    this.handleCurrentChange(this.currentPage);
    this.user = this.logged
      ? JSON.parse(localStorage.getItem("logged_user"))
      : {
          u_avatar: "../../../static/imgs/user/userAvatar.jpg"
        };
    this.avtar = this.user.u_avatar;
  },
  computed: {
    logged() {
      return JSON.parse(localStorage.getItem("pk_user_logged"));
    },
    
    objectInfo(){
      return this.$store.getters.objectInfo;
    },

    commentList() {
      return this.$store.getters.commentList;
    },

    totalItems() {
      return this.$store.getters.commentList.length;
    }
  },
  watch: {},
  methods: {
    async post(){
      console.log("click", );
      let params={
        c_uid:this.user.u_id,
        v_id:this.objectInfo.v_id,
        t_id:this.objectInfo.t_id,
        c_content:this.textarea,
        c_uname:this.user.u_name,
        c_uavatar:this.user.u_avatar
      }
      console.log("params", params);
      let res = this.$http.post("/subComment",{params});
    },

    handleCurrentChange(val) {
      let pageList = [];
      for (
        let i = 5 * (val - 1);
        i < (5 * val < this.totalItems ? 5 * val : this.totalItems);
        i++
      ) {
        pageList.push(this.$store.getters.commentList[i]);
      }
      this.pageList = pageList;

      const returnEle = document.querySelector("#comment"); //window是将要跳转区域的id
      if (!!returnEle) {
        returnEle.scrollIntoView(true); // true 是默认的
      }
      // document.querySelector("counter1").scrollIntoView(true); //这里的counter1是将要返回地方的id
    }
  },
  components: { CommentItem }
};
</script>

<style lang='less' scoped>
.comment-box {
  margin-top: 30px;
  .tip {
    font-size: 26px;
    font-weight: 400;
  }

  .add-comment-wrap {
    margin-top: 10px;
    .avatar {
      float: left;
      display: inline-block;
      width: 64px;
      height: 64px;
      overflow: hidden;
      border: 1px solid rgba(0, 0, 0, 0.1);
      border-radius: 5px;
      img {
        width: 100%;
        height: 100%;
      }
    }
    .text-area {
      margin-left: 20px;
      float: left;
      // .ipt-txt {
      //   font-size: 12px;
      //   display: inline-block;
      //   box-sizing: border-box;
      //   background-color: #f4f5f7;
      //   border: 1px solid #e5e9ef;
      //   overflow: auto;
      //   border-radius: 4px;
      //   color: #555;
      //   width: 100% !important;
      //   height: 65px;
      //   transition: 0s;
      //   padding: 5px 10px;
      //   line-height: normal;
      // }

      // .ipt-txt:hover{
      //   background: white;
      // }
    }
    .publish-button {
      float: right;
      .button-style {
        width: 70px;
        height: 64px;
        padding: 4px 15px;
        font-size: 14px;
        color: #fff;
        border-radius: 4px;
        text-align: center;
        min-width: 60px;
        vertical-align: top;
        cursor: pointer;
        background-color: #00a1d6;
        border: 1px solid #00a1d6;
        transition: 0.1s;
        user-select: none;
        outline: none;
      }
    }
  }

  .add-comment-wrap::after {
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
}
</style>
