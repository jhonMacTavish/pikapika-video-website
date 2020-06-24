<template>
  <div class="commentItem-box" @mouseenter="setReportable" @mouseleave="setReportable">
    <div class="avatar">
      <img :src="listItem.avatar?listItem.avatar:avatar" alt />
    </div>
    <div class="content">
      <div class="header-wrap">
        <div class="userid">{{listItem.username}}</div>
        <!-- <div class="subtime">{{listItem.create_time}}</div> -->
        <div class="subtime">{{listItem.create_time.replace(/T|:\d{2}.000Z/g," ")}}</div>
      </div>
      <p>{{listItem.content}}</p>
      <div class="praise-wrap">
        <span
          class="like"
          @click="like(listItem.comment_id,1)"
          @mouseenter="enter($event)"
          @mouseleave="leave($event)"
        >
          <img ref="like" :src="`@/../static/imgs/praise/praise${is_praise===1?'_active':''}.png`" />
          <span v-text="likeNum"></span>
        </span>
        <span
          class="hate"
          @click="like(listItem.comment_id,0)"
          @mouseenter="enter($event)"
          @mouseleave="leave($event)"
        >
          <img ref="hate" :src="`@/../static/imgs/praise/praise${is_praise===0?'_active':''}.png`" />
          <span v-text="hateNum"></span>
        </span>
      </div>
      <el-button
        v-if="listItem.deletable"
        type="text"
        @click="remove(listItem)"
        class="delete-button"
      >删除</el-button>
      <el-button
        v-if="logged && reportable && !listItem.deletable"
        type="text"
        @click="openDialog(listItem.comment_id)"
        class="delete-button"
      >举报</el-button>
    </div>
    <el-dialog
      title="举报理由"
      :close-on-click-modal="false"
      :visible.sync="dialogVisible"
      width="360px"
    >
      <el-input
        type="textarea"
        rows="5"
        placeholder="请输入举报理由，字数限制100字"
        v-model="reason"
        clearable
        maxlength="100"
        show-word-limit
      ></el-input>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="report">举 报</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
const jwt = require("jsonwebtoken");
export default {
  name: "CommentItem",
  props: {
    listItem: {},
    showReview: false
  },
  data() {
    return {
      reportable: false,
      avatar: "../../../../static/imgs/user/userAvatar.jpg",
      deletable: false,
      dialogVisible: false,
      comment_id: null,
      reason: "",
      is_praise: 2,
      likeNum: 0,
      hateNum: 0
    };
  },
  computed: {
    logged() {
      if (localStorage.token) {
        return true;
      } else {
        return false;
      }
    }
  },
  watch: {},
  created() {
    this.is_praise = this.listItem.is_praise;
    this.likeNum = this.listItem.likeNum;
    this.hateNum = this.listItem.hateNum;
  },
  methods: {
    async like(comment_id, is_praise) {
      if(!localStorage.token){
        this.$message({
          type:"error",
          message:"请先登录"
        });
        return
      }
      let params = { comment_id, is_praise };
      const res = await this.$http.post("/comments/like", { params });
      this.is_praise = res.data.is_praise;
      this.likeNum = res.data.likeNum;
      this.hateNum = res.data.hateNum;
    },

    enter(e) {
      if (e.target.firstElementChild.src.indexOf("_active") !== -1) return;
      e.target.firstElementChild.src =
        "@/../static/imgs/praise/praise_hover.png";
    },

    leave(e) {
      if (e.target.firstElementChild.src.indexOf("_active") !== -1) {
        e.target.firstElementChild.src =
          "@/../static/imgs/praise/praise_active.png";
      } else {
        e.target.firstElementChild.src = "@/../static/imgs/praise/praise.png";
      }
    },

    openDialog(comment_id) {
      this.dialogVisible = true;
      this.comment_id = comment_id;
    },

    setReportable() {
      this.reportable = !this.reportable;
    },

    async remove(comment_id) {
      let res = await this.$http.delete(`/comments/${comment_id}`);
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        this.$store.commit("UpdateCommentList", res.data.list);
        this.$emit("refreshList", 1);
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
      }
    },

    async report() {
      if (!this.reason) {
        this.$message({
          type: "error",
          message: "举报理由不能为空"
        });
        return;
      }
      let reason = this.reason;
      let comment_id = this.comment_id;
      let params = { comment_id, reason };
      let res = await this.$http.post("/comments/report", { params });
      this.dialogVisible = false;
      if (res.data.status == 200) {
        this.$message({
          type: "success",
          message: res.data.msg
        });
        return;
      } else {
        this.$message({
          type: "error",
          message: res.data.msg
        });
        return;
      }
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.commentItem-box {
  position: relative;
  margin-top: 20px;
  border-bottom: 1px solid #e5e9ef;
  .avatar {
    float: left;

    // margin-bottom: 6px;
    margin: 10px;
    display: inline-block;
    width: 48px;
    height: 48px;
    border: 1px solid rgba(0, 0, 0, 0.1);
    border-radius: 50%;
    img {
      width: 100%;
      height: 100%;
      border-radius: 50%;
    }
  }

  .content {
    float: right;
    margin-top: 10px;
    width: 93%;
    display: inline-block;
    min-height: 48px;
    font-size: 14px;

    .header-wrap {
      position: relative;
      width: 100%;
      .userid {
        float: left;
        color: #00a1d6;
      }

      .subtime {
        font-size: 13px;
        float: right;
        color: #99a2aa;
        margin-right: 10px;
        font-weight: 400;
      }
    }

    .header-wrap::after {
      content: "";
      display: block;
      clear: both;
      visibility: hidden;
    }
    p {
      width: 99%;
      min-height: 50px;
      margin: 10px 0;
      padding-bottom: 20px;
    }
    .praise-wrap {
      // position: absolute;
      float: right;
      margin-bottom: 11px;
      margin-right: 98px;
      display: inline-block;
      height: 16px;
      line-height: 16px;
      font-size: 12px;
      color: #99a2aa;
      // right: 83px;
      img {
        vertical-align: top;
        height: 16px;
        width: 16px;
        right: 5px;
      }
      .like,
      .hate {
        display: inline-block;
        // width: 60px;
      }
      .like {
        margin-right: 20px;
      }
      .hate {
        img {
          transform: rotateX(180deg);
        }
      }
    }
    .delete-button {
      position: absolute;
      // background: red;
      padding: 2px;
      right: 10px;
      bottom: 8px;
    }
  }
}

.commentItem-box:hover {
  box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
  cursor: pointer;
}

.commentItem-box::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}
</style>
