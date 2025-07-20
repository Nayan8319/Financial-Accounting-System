<%-- 
    Document   : login
    Created on : 25 Dec 2023, 17:26:11
    Author     : NSP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            if (session.getAttribute("usertype") != null) {
                if (session.getAttribute("usertype").equals("admin")) {
                    response.sendRedirect("AdminDashboard.jsp");
                } else if (session.getAttribute("usertype").equals("user")) {
                    response.sendRedirect("UserDashboard.jsp");
                }
            }

        %>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login to Medicine Ordering System</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="css/loginAnim.css"/>
        
    </head>
    <body>
        <div class="relative min-h-screen flex">
            <div
                class="flex flex-col sm:flex-row items-center md:items-start sm:justify-center md:justify-start flex-auto min-w-0 bg-white">
                <div class="sm:w-1/2 xl:w-3/6 h-full hidden md:flex flex-auto items-center justify-center p-10 overflow-hidden bg-purple-900 text-white bg-no-repeat bg-cover relative"
                     style="background-image: url(https://images.unsplash.com/photo-1497091071254-cc9b2ba7c48a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1774&q=80);">
                    <div class="absolute bg-gradient-to-b from-black-100 to-blue-500 opacity-50 inset-0 z-0"></div>
                    <div class="w-full max-w-md z-10">
                        <div class="sm:text-4xl xl:text-5xl font-bold leading-tight mb-6">Welcome To Our FMS Login Page!
                        </div>
                        <div class="sm:text-sm xl:text-md text-gray-200 font-normal">

                            Managing your finances has never been easier with our advanced and user-friendly Financial
                            Accounting System.
                            Our login page serves as the gateway to a world of efficient financial management, enabling you
                            to streamline your accounting
                            processes, monitor your transactions, and gain valuable insights into your financial health.

                        </div>
                    </div>
                    <ul class="circles">
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                    </ul>
                </div>
                <div
                    class="md:flex md:items-center md:justify-center w-full sm:w-auto md:h-full w-2/5 xl:w-2/5 p-8 md:p-10 lg:p-14 sm:rounded-lg md:rounded-none bg-white">
                    <div class="max-w-md w-full space-y-8">
                        <div class="text-center">
                            <h2 class="mt-6 text-3xl font-bold text-gray-900">
                                Welcome Back!
                            </h2>
                            <p class="mt-2 text-sm text-gray-500">Please sign in to your account</p>
                        </div>

                        <form class="mt-8 space-y-6">
                            <div class="relative">

                                <label class="ml-3 text-sm font-bold text-gray-700 tracking-wide">Username</label>
                                <input
                                    id="username"
                                    class="w-full text-base px-4 py-2 border-b border-gray-300 focus:outline-none rounded-2xl focus:border-indigo-500"
                                    type="text" placeholder="Enter your username"></input>
                            </div>
                            <div class="mt-8 content-center">
                                <label class="ml-3 text-sm font-bold text-gray-700 tracking-wide">Password</label>
                                <input
                                    id="password"
                                    class="w-full content-center text-base px-4 py-2 border-b rounded-2xl border-gray-300 focus:outline-none focus:border-indigo-500"
                                    type="password" placeholder="Enter your password"></input>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center pl-3">
                                    <div class="flex items-center">
                                        <input checked id="default-radio-2" type="radio" value="user" name="option" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 dark:bg-gray-700 dark:border-gray-600">
                                        <label for="default-radio-2" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">Company user</label>
                                    </div>
                                    <div class="flex items-center ml-3">
                                        <input  id="default-radio-1" type="radio" value="admin" name="option" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 dark:bg-gray-700 dark:border-gray-600">
                                        <label for="default-radio-1" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">Admin</label>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <button type="submit" onclick="return LoginUser()"
                                        class="w-full flex justify-center bg-gradient-to-r from-indigo-500 to-blue-600 hover:bg-gradient-to-l hover:from-blue-500 hover:to-indigo-600 text-gray-100 p-4 rounded-full tracking-wide font-semibold shadow-lg cursor-pointer transition ease-in duration-500">
                                    Log In
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <input id="ajax" type="hidden">
        <script src="js/script.js"></script>
    </body>
</html>