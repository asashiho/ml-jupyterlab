# # TensorFlow & scikit-learn with Python3
FROM jupyter/tensorflow-notebook
LABEL maintainer “Shiho ASA Twitter:@_dr_asa”

# Install JupyterLab
RUN pip install jupyterlab
RUN jupyter serverextension enable --py jupyterlab

# Install Python library for Data Science
RUN pip --no-cache-dir install \
        plotly \
        Pillow \
        google-api-python-client

# Set up Jupyter Notebook config
ENV CONFIG /home/jovyan/.jupyter/jupyter_notebook_config.py
ENV CONFIG_IPYTHON /home/jovyan/.ipython/profile_default/ipython_config.py

RUN jupyter notebook --generate-config --allow-root && \
    ipython profile create

RUN echo "c.NotebookApp.ip = '*'" >>${CONFIG} && \
    echo "c.NotebookApp.open_browser = False" >>${CONFIG} && \
    echo "c.NotebookApp.iopub_data_rate_limit=10000000000" >>${CONFIG} && \
    echo "c.MultiKernelManager.default_kernel_name = 'python3'" >>${CONFIG} 

RUN echo "c.InteractiveShellApp.exec_lines = ['%matplotlib inline']" >>${CONFIG_IPYTHON} 

# Copy sample notebooks.
COPY notebooks /notebooks
