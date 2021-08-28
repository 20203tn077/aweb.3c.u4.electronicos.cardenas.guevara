package mx.edu.utez.electronicos.controller;

import com.google.gson.Gson;
import mx.edu.utez.electronicos.model.address.BeanAddress;
import mx.edu.utez.electronicos.model.address.DaoAddress;
import mx.edu.utez.electronicos.model.device.BeanDevice;
import mx.edu.utez.electronicos.model.device.DaoDevice;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Servlet", value = "/Servlet")
public class Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/main.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        System.out.println("Llamaada");
        System.out.println(action);
        BeanAddress address;
        BeanDevice device;
        switch (action) {
            case "getAllDevices":
                write(response, new DaoDevice().getAllDevices());
                break;
            /*case "getDeviceById":
                break;*/
            case "getAllAddresses":
                write(response, new DaoAddress().getAllAdresses());
                break;
            case "goToUpdate":
                request.setAttribute("device", new DaoDevice().getDeviceById(Integer.parseInt(request.getParameter("id"))));
                request.setAttribute("addresses", new DaoAddress().getAllAdresses());
                request.getRequestDispatcher("views/update.jsp").forward(request,response);
                break;
            case "createDevice":
                device = new BeanDevice();
                address = new BeanAddress();
                if (request.getParameter("address").equals("0")) {
                    address.setStreet(request.getParameter("street"));
                    address.setTown(request.getParameter("town"));
                    address.setZipCode(Integer.parseInt(request.getParameter("zipCode")));
                    address.setState(request.getParameter("state"));
                    address.setCountry(request.getParameter("country"));
                    address.setId(new DaoAddress().createAddress(address));
                } else {
                    address.setId(Integer.parseInt(request.getParameter("address")));
                }
                device.setName(request.getParameter("name"));
                device.setAddress(address);
                new DaoDevice().createDevice(device);
                break;
            case "updateDevice":
                device = new BeanDevice();
                address = new BeanAddress();
                if (request.getParameter("address").equals("0")) {
                    address.setStreet(request.getParameter("street"));
                    address.setTown(request.getParameter("town"));
                    address.setZipCode(Integer.parseInt(request.getParameter("zipCode")));
                    address.setState(request.getParameter("state"));
                    address.setCountry(request.getParameter("country"));
                    address.setId(new DaoAddress().createAddress(address));
                } else {
                    address.setId(Integer.parseInt(request.getParameter("address")));
                }
                device.setId(Integer.parseInt(request.getParameter("id")));
                device.setName(request.getParameter("name"));
                device.setAddress(address);
                new DaoDevice().updateDevice(device);
                doGet(request,response);
                break;
            case "deleteDevice":
                new DaoDevice().deleteDevice(Integer.parseInt(request.getParameter("id")));
                doGet(request,response);
                break;
            default:
        }
    }
    private void write(HttpServletResponse response, Object obj) throws IOException{
        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(obj));
    }
}
