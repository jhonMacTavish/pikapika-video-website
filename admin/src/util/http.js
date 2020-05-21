import axios from 'axios'
import Vue from 'vue'
import router from '../router'

const http = axios.create({
    baseURL: 'http://localhost:3000/admin/api'
})

http.interceptors.request.use(function (config) {
    if (localStorage.token) {
        config.headers.Authorization = 'Bearer ' + localStorage.token;
    }
    return config
}, function (error) {
    return Promise.reject(error);
})

http.interceptors.response.use(res => {
    return res;
}, err => {
    if (err.response.status == 422 && router.history.current.path != "/login") {
        Vue.prototype.$message({
            type: 'error',
            message: err.response.data.message
        });
        router.push('/login');
    }
    else if (err.response.data.message && err.response.status != 422) {
        if (router.history.current.path != "/login") {
            Vue.prototype.$message({
                type: 'error',
                message: err.response.data.message
            });
        }

        if (err.response.status == 401) {
            router.push('/login');
        }
    }
});

export default http 