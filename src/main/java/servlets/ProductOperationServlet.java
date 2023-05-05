package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import mycart.dao.CategoryDao;
import mycart.dao.ProductDao;
import mycart.entities.Category;
import mycart.entities.Product;
import mycart.helper.FactoryProvider;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductOperationServlet() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String op = request.getParameter("operation");

			if (op.trim().equals("addcategory")) {
				// add category
				// fetching category data
				String title = request.getParameter("catTitle");
				String discription = request.getParameter("catDescription");

				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(discription);

				// save category into database
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				int catId = categoryDao.saveCategory(category);

				PrintWriter out = response.getWriter();
				out.println("Category saved");
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Category added successfully : " + catId);
				response.sendRedirect("admin.jsp");
				return;

			} else if (op.trim().equals("addproduct")) {
				// add product
				String pName = request.getParameter("pName");
				String pDesc = request.getParameter("pDesc");
				int pPrice = Integer.parseInt(request.getParameter("pPrice"));
				int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
				int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
				int catId = Integer.parseInt(request.getParameter("catId"));
				Part part = request.getPart("pPic");

				Product p = new Product();
				p.setpName(pName);
				p.setpDesc(pDesc);
				p.setpPrice(pPrice);
				p.setpDiscount(pDiscount);
				p.setpQuantity(pQuantity);
				p.setpPhoto(part.getSubmittedFileName());

				// get category by id
				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				Category category = cdao.getCategoryById(catId);
				p.setCategory(category);

				// product save
				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				pdao.saveProduct(p);

				// image upload
				String path = request.getRealPath("img") + File.separator + "Products" + File.separator
						+ part.getSubmittedFileName();
				System.out.println(path);

				try {
					// uploading code..
					FileOutputStream fos = new FileOutputStream(path);
					InputStream is = part.getInputStream();

					// reading data
					byte[] data = new byte[is.available()];
					is.read(data);

					// writing the data
					fos.write(data);
					fos.close();

				} catch (Exception e) {
					e.printStackTrace();
				}

				PrintWriter out = response.getWriter();
				out.println("Product saved");

				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Product added successfully");
				response.sendRedirect("admin.jsp");
				return;

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
