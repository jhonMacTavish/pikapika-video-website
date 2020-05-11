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
          :cols="128"
          :maxlength="430"
          size="medium"
          :placeholder="logged?'请自觉遵守物联网相关的政策法规，严禁发布色情、暴力、反动的言论':'请先登录'"
        ></el-input>
      </div>
      <div class="publish-button">
        <!-- <el-button type="primary" class="button-style" :disabled="true">主要按钮</el-button> -->
        <button class="button-style" :disabled="!logged" @click="post">发表评论</button>
      </div>
    </div>
    <div>
      <CommentItem
        v-for="(item,index) in pageList"
        @refreshList="handleCurrentChange"
        :key="index"
        :listItem="item"
      />
      <div v-if="!totalItems">
        <div class="space">
          暂未有评论
        </div>
      </div>
    </div>
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
      avtar: ""
    };
  },
  computed: {
    user() {
      return JSON.parse(localStorage.getItem("logged_user"));
    },

    logged() {
      return JSON.parse(localStorage.getItem("pk_user_logged"));
    },

    objectInfo() {
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
  async created() {
    await this.fetch();
    this.handleCurrentChange(this.currentPage);
    // this.user = this.logged
    //   ? JSON.parse(localStorage.getItem("logged_user"))
    //   : {
    //       u_avatar: "../../../static/imgs/user/userAvatar.jpg"
    //     };
    // console.log("user/****************************************************", this.user);
    this.avtar =
      (this.user ? this.user : {}).u_avatar ||
      "../../../static/imgs/user/userAvatar.jpg";
  },
  methods: {
    async fetch() {
      let params = this.$route.query;
      console.log("params", params);
      let res = await this.$http.get("/comments", { params });
      this.$store.commit("UpdateCommentList", res.data.list);
      this.handleCurrentChange(this.currentPage);
    },

    async post() {
      console.log("click");
      console.log("this.user", this.user);
      let params = {
        c_uid: this.user.u_id,
        v_id: this.objectInfo.v_id,
        t_id: this.objectInfo.t_id,
        c_content: this.textarea,
        c_uname: this.user.u_name,
        c_uavatar: this.user.u_avatar
      };
      console.log("params", params);
      let res = await this.$http.post("/comments", { params });
      // console.log("res", res);
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        console.log("res", res.data.list);
        this.$store.commit("UpdateCommentList", res.data.list);
        this.textarea = "";
        this.currentPage = 1;
        this.handleCurrentChange(this.currentPage);
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    },

    handleCurrentChange(val) {
      // console.log("remove");
      let pageList = [];
      for (
        let i = 5 * (val - 1);
        i < (5 * val < this.totalItems ? 5 * val : this.totalItems);
        i++
      ) {
        pageList.push(this.commentList[i]);
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
  margin-top: 20px;
  .tip {
    margin-top: 40px;
    font-size: 26px;
    font-weight: 400;
  }

  .space{
    margin-top: 40px;
    width: 100%;
    height: 50px;
    line-height: 50px;
    text-align: center;
  }

  .add-comment-wrap {
    margin-top: 30px;
    .avatar {
      float: left;
      display: inline-block;
      width: 74px;
      height: 73px;
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
      height: 75px;
    }
    .publish-button {
      float: right;
      .button-style {
        width: 80px;
        height: 75px;
        padding: 4px 20px;
        font-size: 18px;
        color: #fff;
        border-radius: 4px;
        text-align: center;
        min-width: 70px;
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
